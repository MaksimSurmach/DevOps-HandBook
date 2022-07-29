### Volumes

## EmptyDir

# https://kubernetes.io/docs/concepts/storage/volumes/#emptydir

containers:
    - name: nginx
      image: nginx:alpine
      imagePullPolicy: IfNotPresent
      volumeMounts:
      - mountPath: /usr/share/nginx/html/
        name: shared-pod-volume
volumes:
    - name: shared-pod-volume
      emptyDir: {}

# Or HostPath 

volumes:
  - name: test-volume
    hostPath:
      path: /data              # directory location on host
      type: DirectoryOrCreate  # this field is optional

# For better perfomance to tell Kubernetes to mount a tmpfs (RAM-backed filesystem) for you instead

volumes:
  - name: docker
    emptyDir:
      medium: Memory


## Persistent Volumes

A PersistentVolume (PV):
    is a piece of storage in the cluster that has been provisioned by an administrator or dynamically provisioned using Storage Classes. It is a resource in the cluster just like a node is a cluster resource. PVs are volume plugins like Volumes, but have a lifecycle independent of any individual Pod that uses the PV. This API object captures the details of the implementation of the storage, be that NFS, iSCSI, or a cloud-provider-specific storage system.

kubectl get pv


A PersistentVolumeClaim (PVC):
    It’s a request for storage by a user. It is similar to a Pod. Pods consume node resources and PVCs consume PV resources. Pods can request specific levels of resources (CPU and Memory). Claims can request specific size and access modes (e.g., they can be mounted once read/write or many times read-only).

kubectl get pvc

# https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modess

apiVersion: v1
kind: PersistentVolume
metadata:
  name: mysql-pv-volume
  labels:
    type: local
spec:
  storageClassName: manual
  capacity:
    storage: 20Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/mnt/data"
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mysql-pv-claim
spec:
  storageClassName: manual
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 20Gi

# on pod or Deploy
 volumes:
      - name: mysql-persistent-storage
        persistentVolumeClaim:
          claimName: mysql-pv-claim


## Storage Classes

There are two ways PVs may be provisioned: statically or dynamically:

Static - way means that you have to specify PV and PVC should be configured to utilize existing PVs - all what we did on previous scenarios
Dynamic - implies the storage resources are dynamically provisioned using the provisioner specified by the StorageClass object. StorageClasses are essentially blueprints that abstract away the underlying storage provider, as well as other parameters, like disk-type (e.g.; solid-state vs standard disks).

k get sc
kubectl get storageclass << sc_name >>
kubectl describe storageclass << sc_name >>

# Example of StorageClass

apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mypvc
  namespace: testns
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 100Gi
  
  # Storage Class to be used
  storageClassName: gold

# AWS efs yaml example 

kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: efs-sc
provisioner: efs.csi.aws.com
parameters:
  provisioningMode: efs-ap
  fileSystemId: fs-92107410
  directoryPerms: "700"
  gidRangeStart: "1000" # optional
  gidRangeEnd: "2000" # optional
  basePath: "/dynamic_provisioning" # optional


# Change default storage class

kubectl patch storageclass <storage-class-name> -p '{
  "metadata": {
    "annotations": {
      "storageclass.kubernetes.io/is-default-class":"true"
    }
  }
}'

# https://kubernetes.io/docs/tasks/administer-cluster/change-default-storage-class/