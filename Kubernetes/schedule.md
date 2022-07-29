

# https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector
# select node
spec:
    nodeName: node01


spec:
    nodeSelector:
        kubernetes.io/os: linux

# set label to node
    kubectl label nodes <node-name> <label-key>=<label-value>


# affinity
# kubectl get nodes --label-columns <label> --label-columns <label>
# https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity
spec:
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: topology.kubernetes.io/region
            operator: In
            values:
            - us-west-1
            - us-east-1
      preferredDuringSchedulingIgnoredDuringExecution:
      - weight: 1
        preference:
          matchExpressions:
          - key: node.kubernetes.io/instance-type
            operator: In
            values:
            - m5.4xlarge


# Pod affinity

spec:
  affinity:
    podAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
      - labelSelector:
          matchExpressions:
          - key: app
            operator: In
            values:
            - store
        topologyKey: "kubernetes.io/hostname"
# https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#never-co-located-in-the-same-node


# Taint and toleration
# show node taints kubectl get nodes -o custom-columns=NAME:.metadata.name,TAINTS:.spec.taints --no-headers
  tolerations:
  - key: "key1"
    operator: "Equal"
    value: "value1"
    effect: "NoSchedule"

effect
- effect - New pods that do not match the taint are not scheduled onto that node.
- PreferNoSchedule - is a “preference” or “soft” version of NoSchedule
- NoExecute - New pods that do not match the taint cannot be scheduled onto that node

operator
- Equal - The key/value/effect parameters must match. This is the default.
- Exists - The key/effect parameters must match. You must leave a blank value parameter, which matches any



# Maintance
# 
# https://kubernetes.io/docs/tasks/administer-cluster/safely-drain-node/

kubectl drain {%node name%}
kubectl drain {%node name%} --ignore-daemonsets

kubectl uncordon {%node name%}



The Kubernetes Scheduler is the component in charge of determining which node is most suitable for running pods.

The Kubernetes Scheduler also honors user-defined factors that affect its decision:

Node Selector: the .spec.nodeSelector parameter in the pod definition narrows down node selection to those having the labels defined in the nodeSelector.
Node affinity and anti-affinity: those are used for greater flexibility in node selection as they allow for more expressive selection criteria. Node affinity can be used to guarantee that only the matching nodes are used or only to set a preference.
Taints and tolerations work in the same manner as node affinity. However, their default action is to repel pods from the tainted nodes unless the pods have the necessary tolerations (which are just a key, a value, and an effect). Tolerations are often combined with node affinity or node selector parameters to guarantee that only the matched nodes are used for pod scheduling.