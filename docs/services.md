# Service Inventory

| Folder | Original Branch | Language | Container Port | Dockerfile Location |
|---|---|---|---:|---|
| `adservice` | `app-ad-serverice` | Java | 9555 | `src/adservice/Dockerfile` |
| `cartservice` | `app-cart-service` | C# / .NET | 7070 | `src/cartservice/src/Dockerfile` |
| `checkoutservice` | `app-checkout-service` | Go | 5050 | `src/checkoutservice/Dockerfile` |
| `currencyservice` | `app-currency-service` | JavaScript / Node.js | 7000 | `src/currencyservice/Dockerfile` |
| `emailservice` | `app-email-service` | Python | 8080 | `src/emailservice/Dockerfile` |
| `frontend` | `app-frontend-service` | Go | 8080 | `src/frontend/Dockerfile` |
| `loadgenerator` | `app-loadgenerator-service` | Python | N/A | `src/loadgenerator/Dockerfile` |
| `paymentservice` | `app-payment-service` | JavaScript / Node.js | 50051 | `src/paymentservice/Dockerfile` |
| `productcatalogservice` | `app-product-catalog-service` | Go | 3550 | `src/productcatalogservice/Dockerfile` |
| `recommendationservice` | `app-recommendation-service` | Python | 8080 | `src/recommendationservice/Dockerfile` |
| `redis` | `app-database` | Redis data store | 6379 | N/A |
| `shippingservice` | `app-shipping-service` | Go | 50051 | `src/shippingservice/Dockerfile` |

## Notes

- `loadgenerator` does not expose a `containerPort` in its Kubernetes deployment.
- `redis` uses the Redis image and does not have its own application Dockerfile in `src/redis/`.