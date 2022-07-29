### ReplicaSet
# https://kubernetes.io/docs/tutorials/stateful-application/basic-stateful-set/


apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: random-generator
spec:
  # References the mandatory Service 
  serviceName: random-generator
  replicas: 3
  selector:
    matchLabels:
      app: random-generator
  template:
    metadata:
      labels:
        app: random-generator
    spec:
      containers:
      - image: sbeliakou/random-generator:1
        name: main
      volumeMounts:
        - name: logs
          mountPath: /logs  
        
  volumeClaimTemplates:                    
  - metadata:
      name: logs
    spec:
      accessModes: [ "ReadWriteOnce" ]
      resources:
        requests:
          storage: 10Mi