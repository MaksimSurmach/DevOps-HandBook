The following information is available to containers through environment variables and downwardAPI volumes:

Information available via fieldRef:

metadata.name - the pod’s name
metadata.namespace - the pod’s namespace
metadata.uid - the pod’s UID
metadata.labels['<KEY>'] - the value of the pod’s label <KEY> (for example, metadata.labels['mylabel'])
metadata.annotations['<KEY>'] - the value of the pod’s annotation <KEY> (for example, metadata.annotations['myannotation'])
Information available via resourceFieldRef:

A Container’s CPU limit
A Container’s CPU request
A Container’s memory limit
A Container’s memory request
A Container’s hugepages limit (providing that the DownwardAPIHugePages feature gate is enabled)
A Container’s hugepages request (providing that the DownwardAPIHugePages feature gate is enabled)
A Container’s ephemeral-storage limit
A Container’s ephemeral-storage request

The following information is available through environment variables:

status.podIP - the pod’s IP address
spec.serviceAccountName - the pod’s service account name
spec.nodeName - the node’s name
status.hostIP - the node’s IP

example:

containers:
      - args:
        - while true; do if [[ -e /podinfo/labels ]]; then echo -en '\n\n'; cat /podinfo/labels;
          fi; if [[ -e /podinfo/annotations ]]; then echo -en '\n\n'; cat /podinfo/annotations; 
        command:
        - sh
        - -c
        image: busybox:1.34
        imagePullPolicy: IfNotPresent
        name: main
        resources:
          limits:
            cpu: 250m
            memory: 64Mi
          requests:
            cpu: 125m
            memory: 32Mi
        env:
        - name: CPU_REQUEST
          valueFrom:
            resourceFieldRef:
              containerName: main
              resource: requests.cpu
        - name: CPU_LIMIT
          valueFrom:
            resourceFieldRef:
              containerName: main
              resource: limits.cpu
        - name: RAM_REQUEST
          valueFrom:
            resourceFieldRef:
              containerName: main
              resource: requests.memory
        - name: RAM_LIMIT
          valueFrom:
            resourceFieldRef:
              containerName: main
              resource: limits.memory
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
        volumeMounts:
        - mountPath: /podinfo
          name: podinfo
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler

      volumes:
      - downwardAPI:
          defaultMode: 420
          items:
          - path: "labels"
            fieldRef:
              fieldPath: metadata.labels
          - path: "annotations"
            fieldRef:
              fieldPath: metadata.annotations
        name: podinfo