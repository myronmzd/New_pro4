**Poject to use kafak**

This is a simple project to demonstrate the use of Apache Kafka for messaging between producers and consumers.

**Implementation Outline (Best-Use Demo)**
1   Producer: FastF1 Telemetry → Kafka

Fetch a race and send data per driver → partitioned topics.

producer.send('telemetry', key=driver.encode(), value=json.dumps(data).encode())

2   Kafka Cluster (MSK recommended)

Use 1 topic per data type, 1 partition per driver

Enable retention (24h or more)

Enable replication factor = 2 to show durability

3️   Consumers

Analytics Consumer (Kafka Streams) → calculates average speed / lap time per driver

Storage Consumer (Python) → dumps raw data to S3 (data lake)

Dashboard Consumer (Flask + WebSocket) → publishes real-time updates to a small dashboard

4️    Visualization

Grafana dashboard (EC2) → connects to DynamoDB or Kafka metrics for live view

QuickSight (AWS) → reads S3 data → generates race summary reports