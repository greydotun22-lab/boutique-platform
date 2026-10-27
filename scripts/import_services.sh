#!/usr/bin/env bash
# import_services.sh - copy each service branch from the "source" remote into src/<service>/
set -euo pipefail

declare -A SERVICES=(
  [app-frontend-service]=frontend
  [app-ad-serverice]=adservice
  [app-cart-service]=cartservice
  [app-checkout-service]=checkoutservice
  [app-currency-service]=currencyservice
  [app-email-service]=emailservice
  [app-loadgenerator-service]=loadgenerator
  [app-payment-service]=paymentservice
  [app-product-catalog-service]=productcatalogservice
  [app-recommendation-service]=recommendationservice
  [app-shipping-service]=shippingservice
  [app-database]=redis
)

git fetch --quiet source

for branch in "${!SERVICES[@]}"; do
  svc="${SERVICES[$branch]}"
  echo "Importing source/$branch -> src/$svc"
  mkdir -p "src/$svc"
  git archive "source/$branch" | tar -x -C "src/$svc"
done

echo "Done: $(find src -mindepth 1 -maxdepth 1 -type d | wc -l) services imported"
