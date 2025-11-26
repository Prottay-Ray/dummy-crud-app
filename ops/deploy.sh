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

echo "Stopping existing container (if any)..."
docker stop "$CONTAINER_NAME" || true
docker rm "$CONTAINER_NAME" || true

echo "Creating persistent data volume for H2 database..."
docker volume create bookdb-data || echo "Volume already exists"

echo "Starting application container with H2 database..."
docker run -d \
  --name "$CONTAINER_NAME" \
  --memory="256m" \
  --memory-swap="256m" \
  --cpus="0.5" \
  --restart unless-stopped \
  -v bookdb-data:/app/data \
  -p 80:8080 \
  "$IMAGE"

echo "Deployment complete."
