# doc file https://kubernetes.io/docs/concepts/configuration/secret/

## create secret 
Available Commands:
  docker-registry Create a secret for use with a Docker registry
  generic         Create a secret from a local file, directory or literal value
  tls             Create a TLS secret

# Create a new secret named my-secret with keys for each file in folder bar
  kubectl create secret generic my-secret --from-file=path/to/bar
# Create a new secret named my-secret with key1=supersecret and key2=topsecret
  kubectl create secret generic my-secret --from-literal=key1=supersecret --from-literal=key2=topsecret

#decode secret
kubectl get secrets/db-user-pass --template={{.data.username}} | base64 -D

$ echo -n 'username' | base64 -w0
dXNlcm5hbWU=

$ echo 'dXNlcm5hbWU=' | base64 -d
username




#secret yaml 
    apiVersion: v1
    kind: Secret
    metadata:
        name: secret-sa-sample
    annotations:
        kubernetes.io/service-account.name: "sa-name"
    type: kubernetes.io/service-account-token
    data:
        # You can include additional key value pairs as you do with Opaque Secrets
        extra: YmFyCg==





apiVersion: v1
data:
  MYSQL_DATABASE: cHJvZHVjdGlvbg==
  MYSQL_PASSWORD: cEFzc3cwcmQ=
  MYSQL_RANDOM_ROOT_PASSWORD: eWVz
  MYSQL_USER: bXN1cm1hY2g=
kind: Secret
metadata:
  creationTimestamp: null
  name: mysql-secret



spec:
  containers:
  - name: container-name
    envFrom:
    - secretRef:
        name: secret-name

  spec:
  containers:
  - name: container-name
    volumeMounts:
    - name: volume-name
      mountPath: /folder/inside/container
  volumes:
  - name: volume-name
    secret:
      secretName: secret-name


## Mounting Secrets Data as Environment variables
spec:
  containers:
  - name: container-name
    env:
    - name: ENV_VARIABLE_NAME
      valueFrom:
        secretKeyRef:
          name: secret-name
          key: secret-key

## add all keys into Pod’s environment
spec:
  containers:
  - name: container-name
    envFrom:
    - secretRef:
        name: secret-name

## Mounting Secrets as Files
spec:
  containers:
  - name: container-name
    volumeMounts:
    - name: volume-name
      mountPath: /folder/inside/container
  volumes:
  - name: volume-name
    secret:
      secretName: secret-name

## docker registry

kubectl create secret docker-registry docker-creds -n default \
 --docker-server=URL \
 --docker-username=USRNAME \
 --docker-password=PASSWD \
 --docker-email=EMAIL

  kubectl patch serviceaccount default -n NAMESPACE \
  --patch '{​​​​​​​
    "imagePullSecrets": [
      {​​​​​​​
        "name": "docker-creds"
      }​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​
    ]
 }​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​'