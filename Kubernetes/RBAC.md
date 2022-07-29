#RBAC UATH
# RBAC CLI https://kubernetes.io/docs/reference/access-authn-authz/rbac/#command-line-utilities
# https://kubernetes.io/docs/reference/access-authn-authz/certificate-signing-requests/#create-private-key
# https://kubernetes.io/docs/reference/access-authn-authz/certificate-signing-requests/#create-certificate-request-kubernetes-object

apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: msurmach
spec:
  signerName: kubernetes.io/kube-apiserver-client
  request: put base64 encoded .csr here
  groups:
  - system:authenticated
  usages:
  - digital signature
  - key encipherment
  - client auth



### if error "Error from server (Forbidden): pods is forbidden: User "msurmach" cannot list resource "pods" in API group "" in the namespace "default""
# https://kubernetes.io/docs/reference/access-authn-authz/rbac/

root@master ~ # kubectl create -n default role pod-viewer \
  --resource=pods \
  --verb=list,get,watch

root@master ~ # kubectl create -n default rolebinding pod-viewer \
  --role=pod-viewer \
  --user=msurmach

## problem 
# https://kubernetes.io/docs/reference/access-authn-authz/rbac/
kubectl get deployment
Error from server (Forbidden): deployments.apps is forbidden: User "msurmach" cannot list resource "deployments" in API group "apps" in the namespace "default"

kubectl create deployment test --image busybox:1.34 -- sleep infinity
error: failed to create deployment: deployments.apps is forbidden: User "msurmach" cannot create resource "deployments" in API group "apps" in the namespace "default"

kubectl create -n default role developer \
  --resource=deployments \
  --verb=get,list,watch,create,update,patch,delete

  kubectl create -n default rolebinding developer \
  --role=developer \
  --user=msurmach


## delete user

kubectl delete clusterrolebindings.rbac.authorization.k8s.io node-viewer
kubectl delete clusterrole node-viewer
kubectl delete -n default role pod-viewer


### RBAC links
https://kubernetes.io/docs/reference/access-authn-authz/rbac/
https://www.adaltas.com/en/2019/08/07/users-rbac-kubernetes/BlbntyfabuEpam7968
https://medium.com/@danielckv/what-is-rbac-in-kubernetes-c54457eff2dc
https://www.magalix.com/blog/kubernetes-rbac-101


### service accounts 
# https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/
https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/
https://docs.openshift.com/container-platform/4.1/openshift_images/managing_images/using-image-pull-secrets.html

### Pulling Images from Private Docker Registry
kubectl create secret docker-registry registry-cred \
 --docker-server=my.private-registry.com \
 --docker-username=msurmach \
 --docker-password="myVeryStronPassword" \
 --docker-email=msurmach@mycompany.com \
 --namespace my-namespace

kubectl create secret generic registry-cred \
  --from-file=.dockerconfigjson=<path/to/.docker/config.json> \
  --type=kubernetes.io/dockerconfigjson


add in spec 
    imagePullSecrets:
    - name: registry-cred
OR add permnentrly
    kubectl patch serviceaccount default -n my-namespace \
  --patch '{
    "imagePullSecrets": [
      {
        "name": "registry-cred"
      }
    ]
  }'

Here’s an example Role in the “default” namespace that can be used to grant read access to pods:
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: default
  name: pod-reader
rules:
- apiGroups: [""] # "" indicates the core API group
  resources: ["pods"]
  verbs: ["get", "watch", "list"]


Here is an example of a ClusterRole:
kind: ClusterRole
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: deployer
rules:
- apiGroups: ["apps"]
  resources: ["deployments"]
  verbs: ["get", "list", "watch", "create", "delete", "update", "patch"]

- apiGroups: [""] # "" indicates the core API group
  resources: ["configmaps", "secrets"]
  verbs: ["get", "list", "watch", "create", "delete", "update", "patch"]

- apiGroups: [""] # "" indicates the core API group
  resources: ["pods"]
  verbs: ["get", "list", "watch"]


  Here is an example of a RoleBinding that grants the “pod-reader” Role to the user “jane” within the “default” namespace. This allows “jane” to read pods in the “default” namespace.

apiVersion: rbac.authorization.k8s.io/v1
# This role binding allows "jane" to read pods in the "default" namespace.
# You need to already have a Role named "pod-reader" in that namespace.
kind: RoleBinding
metadata:
  name: read-pods
  namespace: default
subjects:
# You can specify more than one "subject"
- kind: User
  name: jane # "name" is case sensitive
  apiGroup: rbac.authorization.k8s.io
roleRef:
  # "roleRef" specifies the binding to a Role / ClusterRole
  kind: Role #this must be Role or ClusterRole
  name: pod-reader # this must match the name of the Role or ClusterRole you wish to bind to
  apiGroup: rbac.authorization.k8s.io


The following ClusterRoleBinding allows any user in the group “manager” to read secrets in any namespace
apiVersion: rbac.authorization.k8s.io/v1
# This cluster role binding allows anyone in the "manager" group to read secrets in any namespace.
kind: ClusterRoleBinding
metadata:
  name: read-secrets-global
subjects:
- kind: Group
  name: manager # Name is case sensitive
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: secret-reader
  apiGroup: rbac.authorization.k8s.io



https://medium.com/@danielckv/what-is-rbac-in-kubernetes-c54457eff2dc
https://kubernetes.io/blog/2017/04/rbac-support-in-kubernetes/


Useful Commands:
Checking if RBAC is Enabled / Avaialble API Version:

kubectl api-versions | grep rbac
rbac.authorization.k8s.io/v1
rbac.authorization.k8s.io/v1beta1
Creating resources:

kubectl create sa {SA_NAME} \
  --namespace={NAMESPACE_NAME}

kubectl create role {ROLE_NAME} \
  --namespace={NAMESPACE_NAME} \
  --verb=get,list,watch \
  --resource=pods,pods/status

kubectl create rolebinding {ROLEBINDING_NAME} \
  --role={ROLE_NAME} \
  --serviceaccount={NAMESPACE_NAME}:{SA_NAME} \
  --namespace={NAMESPACE_NAME}
Generating resources manifests:

kubectl create sa {SA_NAME} \
  --namespace={NAMESPACE_NAME} \
  --dry-run=client \
  -o yaml

kubectl create role {ROLE_NAME} \
  --namespace={NAMESPACE_NAME} \
  --verb=get,list,watch \
  --resource=pods,pods/status \
  --dry-run=client \
  -o yaml

kubectl create rolebinding {ROLEBINDING_NAME} \
  --role={ROLE_NAME} \
  --serviceaccount={NAMESPACE_NAME}:{SA_NAME} \
  --namespace={NAMESPACE_NAME} \
  --dry-run=client \
  -o yaml
Checking permissions:

kubectl auth can-i list pods \
  --as=system:serviceaccount:{NAMESPACE_NAME}:{SA_NAME}