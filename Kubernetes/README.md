# Kubernetes


## Alias
`alias k='kubectl'
alias kc='k config view --minify | grep name'
alias kdp='kubectl describe pod'
alias krh='kubectl run --help | more'
alias ugh='kubectl get --help | more'
alias c='clear'
alias kd='kubectl describe pod'
alias ke='kubectl explain'
alias kf='kubectl create -f'
alias kg='kubectl get pods --show-labels'
alias kr='kubectl replace -f'
alias kh='kubectl --help | more'
alias krh='kubectl run --help | more'
alias ks='kubectl get namespaces'
alias l='ls -lrt'
alias ll='vi ls -rt | tail -1'
alias kga='k get pod --all-namespaces'
alias kgaa='kubectl get all --show-labels'`

## CLI commands
### Get Cluster Info
`kubectl cluster-info`

### Get Cluster nodes
`kubectl get nodes`
`kubectl get nodes -o wide`

### Get namespaces
`kubectl get namespaces`

and


`kubectl get namespaces --show-labels`
`kubectl get ns ${NS_NAME}`
`kubectl describe ns ${NS_NAME}`

### Get pods in namespace
`kubectl get pods`
`kubectl get deployment`
`kubectl get pods -n ${NS_NAME}`
`kubectl get pods -A`
`kubectl get pods --all-namespaces`

### Get pod info
`kubectl describe pods ${POD_NAME} -n ${NS_NAME}`
