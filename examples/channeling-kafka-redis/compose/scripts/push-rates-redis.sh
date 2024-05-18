#!/bin/sh

host="${1:-localhost}"
data="{\"data\":{}}"
while read line; do
  if [ -z "${line}" ]; then
    continue
  fi

  timestamp=$(echo "${line}" | jq '{ timestamp: .timestamp }')
  json=$(echo "${line}" | jq '{
  data: .fields
  }')

  data=$(echo "${data}" "${json}" | jq -n 'reduce inputs as $i ({}; . * $i)')
  output=$(echo "${timestamp}" "${data}" | jq -n 'reduce inputs as $i ({}; . * $i)')

  output=$(echo "${output}" | jq '{
    timestamp: .timestamp,
    quote: "usd",
    prices:
      (.data | to_entries | map({
        id: (.key | sub("fields_"; "") | sub("_usd"; "")),
        price: (.value | tostring)
      }))
  }')

  # print to stdout
  echo "${output}" >/dev/stdout
  key=$(echo coingecko:rate:usd | tr -d '"')

  # push to redis
  echo "${output}" | redis-cli -h ${host} -x SET ${key}
done </dev/stdin
