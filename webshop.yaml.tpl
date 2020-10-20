apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: webshop-fronted
  name: webshop-fronted
spec:
  replicas: 1
  selector:
    matchLabels:
      app: webshop-fronted
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: webshop-fronted
    spec:
      containers:
      - image: CLOUD_REP/CLOUD_PROJECT/webshop-vue:COMMIT_SHA
        name: webshop-fronted
        imagePullPolicy: IfNotPresent
        
        resources: {}
---
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  labels:
    app: webshop-fronted
  name: webshop-fronted
spec:
  ports:
  - name: 9090-9090
    port: 9090
    protocol: TCP
    targetPort: 80
  selector:
    app: webshop-fronted
    
  type: LoadBalancer
