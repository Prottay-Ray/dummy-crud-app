#!/usr/bin/env bash
set -e

# Configuration with environment variable support
AWS_REGION="${AWS_REGION:-us-east-1}"
ACCOUNT_ID="${AWS_ACCOUNT_ID:-708735187026}"
REPOSITORY_NAME="${ECR_REPOSITORY:-dummy-crud-app}"
CONTAINER_NAME="${CONTAINER_NAME:-dummy-crud-app}"
IMAGE_TAG="${IMAGE_TAG:-latest}"

# Construct image URI
IMAGE="$ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$REPOSITORY_NAME:$IMAGE_TAG"

echo "=== Deployment Configuration ==="
echo "AWS Region: $AWS_REGION"
echo "AWS Account: $ACCOUNT_ID"
echo "Repository: $REPOSITORY_NAME"
echo "Image Tag: $IMAGE_TAG"
echo "Image: $IMAGE"
echo "================================"
echo ""

echo "Logging in to ECR..."
aws ecr get-login-password --region "$AWS_REGION" \
  | docker login --username AWS --password-stdin "$ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com"

echo "Pulling image: $IMAGE"
docker pull "$IMAGE"

echo "Stopping existing containers (if any)..."
docker stop "$CONTAINER_NAME" mysql-db || true
docker rm "$CONTAINER_NAME" mysql-db || true

echo "Cleaning up any orphaned containers..."
docker ps -a --filter "name=mysql-db" --filter "name=$CONTAINER_NAME" -q | xargs -r docker rm -f || true

echo "Starting MySQL container..."
docker run -d \
  --name mysql-db \
  --memory="400m" \
  --memory-swap="400m" \
  --cpus="0.5" \
  --restart unless-stopped \
  -e MYSQL_ROOT_PASSWORD=rootpassword \
  -e MYSQL_DATABASE=bookdb \
  -p 3306:3306 \
  mysql:8.0 || echo "MySQL already running"

echo "Waiting for MySQL to be ready..."
sleep 20

echo "Verifying MySQL is healthy..."
for i in {1..10}; do
  docker exec mysql-db mysqladmin ping -h localhost -u root -prootpassword > /dev/null 2>&1 && break
  echo "Waiting for MySQL to accept connections... ($i/10)"
  sleep 3
done

echo "Starting new container..."
docker run -d \
  --name "$CONTAINER_NAME" \
  --memory="400m" \
  --memory-swap="400m" \
  --cpus="0.5" \
  --restart unless-stopped \
  --link mysql-db:mysql \
  -e DB_HOST=mysql-db \
  -e DB_PORT=3306 \
  -e DB_NAME=bookdb \
  -e DB_USER=root \
  -e DB_PASSWORD=rootpassword \
  -p 80:8080 \
  "$IMAGE"

echo "Deployment complete."
