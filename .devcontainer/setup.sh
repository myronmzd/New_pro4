#!/bin/bash
set -e

echo "[Setup] Updating packages..."
sudo apt-get update

echo "[Setup] Installing base tools..."
sudo apt-get install -y \
  curl \
  unzip \
  python3-pip

echo "[Setup] Installing Python packages..."
python3 -m pip install --upgrade pip

python3 -m pip install \
  boto3 \
  requests \
  pandas \
  sqlalchemy \
  psycopg2-binary

echo "[Setup] Cleaning up..."
sudo apt-get clean
sudo rm -rf /var/lib/apt/lists/*