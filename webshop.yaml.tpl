apiVersion: v1
kind: ConfigMap
metadata:
  name: postgres-config
  labels:
    app: postgres
data:
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
  storageClassName: manual
  capacity:
    storage: 5Gi
  accessModes:
    - ReadWriteMany
  hostPath:
    path: "/mnt/data"
---
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: postgres-pv-claim
  labels:
    app: postgres
spec:
  storageClassName: manual
  accessModes:
    - ReadWriteMany
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
          image: CLOUD_REP/postgres:10.4
          imagePullPolicy: "IfNotPresent"
          ports:
            - containerPort: 5432
          envFrom:
            - configMapRef:
                name: postgres-config
          volumeMounts:
            - mountPath: /var/lib/postgresql/data
              name: postgredb
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
      - image: CLOUD_REP/CLOUD_PROJECT/order-api:COMMIT_SHA
        name: order-api
        imagePullPolicy: Never
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
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mongo-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 256Mi
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mongo
spec:
  selector:
    matchLabels:
      app: mongo
  template:
    metadata:
      labels:
        app: mongo
    spec:
      containers:
        - name: productdb
          image: CLOUD_REP/CLOUD_PROJECT/productdb:COMMIT_SHA
          imagePullPolicy: Never
          ports:
            - containerPort: 27017
          volumeMounts:
            - name: storage
              mountPath: /data/db
      volumes:
        - name: storage
          persistentVolumeClaim:
            claimName: mongo-pvc
---
apiVersion: v1
kind: Service
metadata:
  name: mongo
spec:
  selector:
    app: mongo
  ports:
    - port: 27017
      targetPort: 27017
---
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: product-api
  name: product-api
spec:
  replicas: 1
  selector:
    matchLabels:
      app: product-api
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: product-api
    spec:
      containers:
      - image: CLOUD_REP/CLOUD_PROJECT/product-api:COMMIT_SHA
        name: product-api
        imagePullPolicy: Never
        env:
              - name: SPRING_PROFILES_ACTIVE
                value: "cloud"

        resources: {}
status: {}
---
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  labels:
    app: product-api
  name: product-api
spec:
  ports:
  - name: 8050-8050
    port: 8050
    protocol: TCP
    targetPort: 8050
  selector:
    app: product-api
  type: LoadBalancer
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
