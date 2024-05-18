# Channeling Kafka Streams into Redis via InfluxData Telegraf

This repository provides a comprehensive guide on how to channel Kafka streams into Redis using InfluxData's Telegraf. It includes step-by-step instructions, configuration examples, and troubleshooting tips. 

The goal is to help developers and data engineers effectively integrate these technologies for real-time data processing and analysis. Whether you're a beginner or an experienced professional, this guide will help you understand and implement this data pipeline.

# Prerequisites

This example is docker-based, so you need to have Docker and Compose installed on your machine. You can download Docker from [here](https://www.docker.com/products/docker-desktop).

# Getting Started

1. Start backend services:

```bash
docker-compose -f compose/backend.yml up -d
```

1. Collect data with Telegraf producer:

```bash
docker-compose -f compose/producer.yml up -d
```

3. Channel Kafka streams into Redis via Telegraf consumer:

```bash
docker-compose -f compose/consumer.yml up -d
```
