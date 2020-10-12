# webshop
trial for using spring-boot, rest api and kubernetes

see also https://github.com/mkjelland/spring-boot-postgres-on-k8s-sample

demo with a rest API implementation with spring-boot fmk, how to configure a database with kubernetes

1) deploy the postgresql database with k8s

kubectl create -f postgres-configmap.yaml
kubectl create -f postgres-storage.yaml
kubectl create -f postgres-deployment.yaml
kubectl create -f postgres-service.yaml

2) build and deploy order-api

mvn clean install
mvn spring-boot:build-image

kubectl get all 
# retrieve IP address of postgresql database
kubectl create configmap hostname-config --from-literal=POSTGRES_HOST="ipaddress:5432"
kubectl create -f webshop-deployment.yaml
kubectl create -f webshop-service.yaml

3)check the logs
kubectl logs deployment/webshop

4)enjoy with the postman collection in the /order-api/src/tests/postman directory










