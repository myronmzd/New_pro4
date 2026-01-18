# Review & Sentiment Pipeline

## Overview

This document outlines the high-level architecture for a Review & Sentiment Pipeline. The system collects user reviews from Reddit, performs sentiment analysis, generates a report, and emails the results to the user.

## Architecture Components

### 1. Frontend (Static Website)

- **Technologies**: HTML and JavaScript
- **Hosting**: Amazon S3 (Static Website) with optional CloudFront for CDN
- **User Inputs**:
  - Topic (e.g., "iPhone 16 Pro")
  - Email address (e.g., user@example.com)
- **Action**: Sends a GET or POST request to API Gateway
- **Example Request**: `GET /review?topic=iPhone%2016%20Pro&email=user@example.com`

### 2. Amazon API Gateway

- **Endpoint**: `/review`
- **Role**:
  - Validates incoming requests
  - Triggers the Lambda function
- **Authentication** (Optional):
  - API Key or IAM/Cognito for future enhancements

### 3. Lambda Function #1 – Data Collection

- **Runtime**: Python
- **Responsibilities**:
  - Parse topic and email from the request
  - Call Reddit API to fetch top ~50 posts related to the topic
  - Store raw data temporarily in S3
- **Output**: Saves a JSON file to `s3://review-temp-bucket/{topic}/raw_posts.json`

### 4. Amazon S3 (Temporary Storage)

- **Bucket Type**: Temporary/processing bucket
- **Stored Data**:
  - Raw Reddit posts
  - Intermediate sentiment analysis results
- **Lifecycle Rule**: Auto-delete objects after X days (e.g., 1 day)

### 5. Lambda Function #2 – Sentiment & Report Generation

- **Trigger**: S3 upload event or AWS Step Functions (recommended for orchestration)
- **Responsibilities**:
  - Read Reddit posts from S3
  - Perform sentiment analysis using Amazon Comprehend or custom Python NLP
  - Generate a summary report including:
    - Positive/Negative/Neutral sentiment breakdown
    - Top complaints
    - Overall sentiment score
  - Save the final report to S3 (PDF or text format)

### 6. Email Delivery

- **Service**: Amazon SES (recommended) or Amazon SNS (email protocol)
- **Action**: Send the report via email to the provided address
- **Options**:
  - Attach the report file
  - Include a summary with a link to the S3 report

### 7. Cleanup & Finalization

- **Delete**:
  - Temporary Reddit data
  - Intermediate sentiment files
- **Retention**:
  - Final report (optional, based on policy)
- **Mechanism**: S3 lifecycle rules and Lambda cleanup logic

## Architecture Flow Diagram

```
User Browser
  |
  |  (HTML Form: topic + email)
  v
Static Website (S3 + CloudFront)
  |
  |  GET /review?topic=iPhone%2016%20Pro&email=user@example.com
  v
API Gateway (/review)
  |
  v
Lambda #1 (Fetch Reddit Data)
  |
  v
Reddit API
  |
  v
S3 (Temporary Storage)
  |
  v
Lambda #2 (Sentiment + Report)
  |
  v
S3 (Final Report)
  |
  v
Amazon SES (Email Report)
  |
  v
User Email Inbox
```
