### Config map

A ConfigMap is a dictionary of configuration settings. This dictionary consists of key-value pairs of strings. Kubernetes provides these values to your containers. Like with other dictionaries (maps, hashes, …) the key lets you get and set the configuration value.

# https://unofficial-kubernetes.readthedocs.io/en/latest/tasks/configure-pod-container/configmap/

kubectl get configmap
kubectl get cm

kubectl create configmap <map-name> <data-source>

# Download the sample files into `configure-pod-container/configmap/` directory
wget https://kubernetes.io/examples/configmap/game.properties -O configure-pod-container/configmap/game.properties
# Create the configmap
kubectl create configmap game-config --from-file=configure-pod-container/configmap/
# Create a new configmap named my-config with key1=config1 and key2=config2
kubectl create configmap my-config --from-literal=key1=config1 --from-literal=key2=config2

# https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/
yaml Example: 
apiVersion: v1
kind: ConfigMap
metadata:
  name: game-demo
data:
  # property-like keys; each key maps to a simple value
  player_initial_lives: "3"
  ui_properties_file_name: "user-interface.properties"

  # file-like keys
  game.properties: |
    enemy.types=aliens,monsters
    player.maximum-lives=5    
  user-interface.properties: |
    color.good=purple


## add keys as env

spec:
  containers:
  - name: container-name
    envFrom:
    - configMapRef:
        name: configmap-name
        