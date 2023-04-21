kubectl apply -f k8s-config.yaml
kubectl apply -f k8s-secret.yaml

# should not be a part of restart as all data would be lost
# but must be a part of a new deployment
#kubectl apply -f k8s-databases.yaml

kubectl apply -f k8s-clients.yaml
kubectl apply -f k8s-books.yaml
kubectl apply -f k8s-cart.yaml
kubectl apply -f k8s-storage.yaml
kubectl apply -f k8s-orders.yaml
kubectl apply -f k8s-payment.yaml
kubectl apply -f k8s-dynapay.yaml
kubectl apply -f k8s-ingest.yaml
kubectl apply -f k8s-ratings.yaml
kubectl apply -f k8s-bookstore.yaml