#!/usr/bin/env bash
set -euo pipefail

REMOTE="source"

SERVICES=(
  "app-loadgenerator-service"
  "app-payment-service"
  "app-product-catalog-service"
  "app-recommendation-service"
  "app-shipping-service"
)

for SERVICE in "${SERVICES[@]}"; do
  echo "Importing $SERVICE..."

  mkdir -p "services/$SERVICE"

  git archive "$REMOTE/$SERVICE" \
    | tar -x -C "services/$SERVICE"

  echo "Imported $SERVICE"
done

echo "All services imported successfully."