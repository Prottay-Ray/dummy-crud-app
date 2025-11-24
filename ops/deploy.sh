#!/usr/bin/env bash
set -e

AWS_REGION="us-east-1"                # e.g. ap-south-1
ACCOUNT_ID="557215975243"           # 12-digit AWS account id
REPOSITORY_NAME="dummy-crud-app"         # ECR repo name
IMAGE="$ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$REPOSITORY_NAME:latest"
CONTAINER_NAME="dummy-crud-app"

echo "Logging in to ECR..."
aws ecr get-login-password --region "$AWS_REGION" \
  | docker login --username AWS --password-stdin "$ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com"

echo "Pulling latest image: $IMAGE"
docker pull "$IMAGE"

echo "Stopping existing container (if any)..."
docker stop "$CONTAINER_NAME" || true
docker rm "$CONTAINER_NAME" || true

echo "Starting new container..."
docker run -d \
  --name "$CONTAINER_NAME" \
  -p 80:8080 \
  "$IMAGE"

echo "Deployment complete."
