#!/usr/bin/env bash
set -e

AWS_REGION="us-east-1"
ACCOUNT_ID="708735187026"
REPOSITORY_NAME="dummy-crud-app"
CONTAINER_NAME="dummy-crud-app"

# Use IMAGE_TAG environment variable if provided, otherwise use 'latest'
# For immutable ECR repos, you should provide the specific tag
IMAGE_TAG="${IMAGE_TAG:-latest}"
IMAGE="$ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$REPOSITORY_NAME:$IMAGE_TAG"

echo "Logging in to ECR..."
aws ecr get-login-password --region "$AWS_REGION" \
  | docker login --username AWS --password-stdin "$ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com"

echo "Pulling image: $IMAGE"
docker pull "$IMAGE"

echo "Stopping existing container (if any)..."
docker stop "$CONTAINER_NAME" || true
docker rm "$CONTAINER_NAME" || true

echo "Starting MySQL container (if not running)..."
docker run -d \
  --name mysql-db \
  -e MYSQL_ROOT_PASSWORD=rootpassword \
  -e MYSQL_DATABASE=bookdb \
  -p 3306:3306 \
  mysql:8.0 || echo "MySQL already running"

echo "Waiting for MySQL to be ready..."
sleep 10

echo "Starting new container..."
docker run -d \
  --name "$CONTAINER_NAME" \
  --link mysql-db:mysql \
  -e DB_HOST=mysql-db \
  -e DB_PORT=3306 \
  -e DB_NAME=bookdb \
  -e DB_USER=root \
  -e DB_PASSWORD=rootpassword \
  -p 80:8080 \
  "$IMAGE"

echo "Deployment complete."
