apiVersion: v1
kind: ConfigMap
metadata:
  name: postgres-config
  labels:
    app: postgres
data:
  PGDATA: /var/lib/postgresql/data/pgdata
  POSTGRES_DB: orderdb
  POSTGRES_USER: postgres
  POSTGRES_PASSWORD: postgresdb
---
apiVersion: v1
kind: Service
metadata:
  name: postgres
  labels:
    app: postgres
spec:
  type: ClusterIP
  ports:
   - port: 5432
  selector:
   app: postgres
---
kind: PersistentVolume
apiVersion: v1
metadata:
  name: postgres-pv-volume
  labels:
    type: local
    app: postgres
spec:
  storageClassName: standard
  capacity:
    storage: 5Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/var/lib/postgresql/data"
---
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: postgres-pv-claim
  labels:
    app: postgres
spec:
  storageClassName: standard
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 5Gi
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: postgres
spec:
  selector:
    matchLabels:
      app: postgres
  replicas: 1
  template:
    metadata:
      labels:
        app: postgres
    spec:
      containers:
        - name: postgres
          image: gcr.io/cloud-marketplace/google/postgresql:9.6.19-20201025-141411
          imagePullPolicy: Always
          ports:
            - containerPort: 5432
          envFrom:
            - configMapRef:
                name: postgres-config
          volumeMounts:
            - mountPath: /var/lib/postgresql/data
              name: postgredb
          resources:
            requests:
              cpu: "100m"
              memory: "100Mi"
        
      volumes:
        - name: postgredb
          persistentVolumeClaim:
            claimName: postgres-pv-claim
---
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  labels:
    app: order-api
  name: order-api
spec:
  ports:
  - name: 8080-8080
    port: 8080
    protocol: TCP
    targetPort: 8080
  selector:
    app: order-api
  type: LoadBalancer
---
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: order-api
  name: order-api
spec:
  replicas: 1
  selector:
    matchLabels:
      app: order-api
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: order-api
    spec:
      containers:
      - image: gcr.io/CLOUD_PROJECT/order-api:COMMIT_SHA
        name: order-api
        imagePullPolicy: IfNotPresent
        env:
              - name: SPRING_PROFILES_ACTIVE
                value: "cloud"
              - name: POSTGRES_USER
                valueFrom:
                  configMapKeyRef:
                    name: postgres-config
                    key: POSTGRES_USER
              - name: POSTGRES_PASSWORD
                valueFrom:
                  configMapKeyRef:
                    name: postgres-config
                    key: POSTGRES_PASSWORD
              - name: POSTGRES_DB
                valueFrom:
                  configMapKeyRef:
                    name: postgres-config
                    key: POSTGRES_DB

        resources: {}
status: {}
---
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
      - image: gcr.io/CLOUD_PROJECT/webshop-vue:COMMIT_SHA
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
---
apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  name: webshop-ing
  annotations:
    kubernetes.io/ingress.class: nginx
    kubernetes.io/ingress.global-static-ip-name: "web-static-ip"
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - http:
      paths:
      - path: /*
        backend:
          serviceName: webshop-fronted
          servicePort: 9090
      - path: /api/*
        backend:
          serviceName: order-api
          servicePort: 8080        
