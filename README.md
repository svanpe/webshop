# Webshop (POC) 
This is a trial for training purpose about making an app with spring-boot for REST api's and Kubernetes.

I found a lot of support from the following projects found on the web :

https://github.com/mkjelland/spring-boot-postgres-on-k8s-sample
https://github.com/tudordascalu/Vue-Webshop
https://cloud.google.com/kubernetes-engine/docs/tutorials/gitops-cloud-build


# LOCAL DEMO
demo with a rest API implementation with spring-boot fmk, how to configure a database with kubernetes

1) build image webshop/order-api
 
cd /order-api
mvn clean install
mvn spring-boot:build-image

2) deploy the postgresql database and the order api with k8s

cd /webshop-specs
kubectl create -f postgres-configmap.yaml
kubectl create -f postgres-storage.yaml
kubectl create -f postgres-deployment.yaml
kubectl create -f postgres-service.yaml
kubectl create -f order-deployment.yaml
kubectl create -f order-service.yaml


kubectl get all 
'kubectl create configmap hostname-config --from-literal=POSTGRES_HOST="ipaddress:5432"

3)check the logs
kubectl logs deployment/webshop

4)enjoy with the postman collection in the /order-api/src/tests/postman directory

# ON GOOGLE CLOUD

install INGRESS 
gcloud container clusters create webshop-demo --num-nodes 1 --zone us-central1-b

kubectl create clusterrolebinding cluster-admin-binding --clusterrole cluster-admin --user $(gcloud config get-value account)
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/nginx-0.30.0/deploy/static/mandatory.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/nginx-0.30.0/deploy/static/provider/cloud-generic.yaml

gcloud compute addresses create web-static-ip --global 



