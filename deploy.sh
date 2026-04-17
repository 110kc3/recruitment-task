#!/usr/bin/env bash
set -e

ENV="$1"
ROOT="$(cd "$(dirname "$0")" && pwd)"

#Terraform
cd "$ROOT/terraform"
terraform init -input=false -upgrade
terraform apply -input=false -auto-approve \
  -var-file="environments/${ENV}.tfvars" \
  -var="environment=${ENV}" \
  -var="db_password=${DB_PASSWORD}"

DB_HOST=$(terraform output -raw db_endpoint)
DB_PORT=$(terraform output -raw db_port)
DB_NAME=$(terraform output -raw db_name)
DB_USER=$(terraform output -raw db_username)

# Helm
cd "$ROOT"
kubectl create namespace "app-${ENV}" --dry-run=client -o yaml | kubectl apply -f -
kubectl label namespace "app-${ENV}" istio-injection=enabled --overwrite

helm upgrade --install "app-${ENV}" helm/app-chart \
  -n "app-${ENV}" \
  --set "db.host=$DB_HOST" \
  --set "db.port=$DB_PORT" \
  --set "db.name=$DB_NAME" \
  --set "db.user=$DB_USER" \
  --set "db.password=$DB_PASSWORD" \
  --wait --timeout 5m
