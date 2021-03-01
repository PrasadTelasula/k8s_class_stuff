# Pod Manifest
# save it in pod.yml
apiVersion: v1
kind: Pod
metadata:
  name: californiaapp
spec:
  containers:
  - name: californiaapp
    image: subaniprasad/californiaapp:1
    
# Create pod from manifest
kubectl apply -f pod.yml

# Check pod status
kubectl get pods

# Check in which worker node pod got deployed
kubectl get pods -o wide

# Connect to the pod
kubectl exec -it california -- bash

# Get logs of a pod
kubectl logs -f california

# Describe pod
kubectl describe california

# Delete a pod
kubectl delete -f pod.yml

#########################################
######## Multi Container Pod ############
#########################################

# Pod Manifest
apiVersion: v1
kind: Pod
metadata:
  name: multi-containers
spec:
  containers:
  - name: nginx
    image: nginx
    ports:
    - containerPort: 80
  - name: alpine
    image: alpine
    command: ["watch", "wget", "--server-response", "http://localhost"]
#################

# Create multi container pod
kubectl apply -f multi-cotainer.yml

# Check the pod status and in which node it is scheduled
kubectl get pods -o wide

# Inspect the pod at containers section
kubectl describe pod multi-containers

# Print the names of the containers
kubectl get pods multi-containers -o jsonpath='{.spec.containers[*].name}{"\n"}'
kubectl get pods multi-containers -o jsonpath='{.spec.containers[*].name}{"\n"}' | tr -s '[[:space:]]' '\n'

# Connect to alpine container
kubectl exec -it multi-containers -c alpine -- sh
    apk add curl
    curl localhost

# Connect to nginx container
kubectl exec -it multi-containers -c nginx -- bash

# Check the logs of alpine container
kubectl logs -f multi-containers -c alpine

# Check the IP address of both container
kubectl exec -it multi-containers -c alpine -- hostname -i
kubectl exec -it multi-containers -c nginx -- hostname -i

# Check the hostnames of both containers
kubectl exec -it multi-containers -c alpine -- hostname
kubectl exec -it multi-containers -c nginx -- hostname



# Connect to the worker node in which pod got created
# Connect to root user and
docker ps | grep multi-containers

# Observe two containers will be displayed
# 1. Pause container
# 2. Main container

# Execute top command on two docker containers.
docker top PAUSE_COTAINER_ID
docker top MAIN_CONTAINER_ID

# Observe Parent process ID is same for both containers
readlink /proc/<PID>/task/<PID>/ns/*
# Example
# readlink /proc/18458/task/18458/ns/*
# Below namespaces shared between two containers.
# 1. IPC
# 2. NET
# 3. USER
# Containers within the POD will share the same network namespace (i.e means containers within the POD's will share the same IP & can communicate with each other through localhost address)

# Pause is a secret container that runs on every pod in Kubernetes. This container’s primary job is to keep the namespace open in case all the other containers on the pod die.

# Delete alpine container and watch new alpine container will be created and there will be no change in the Pod IP.

# Delete nginx container and watch new alpine container will be created and there will be no change in the Pod IP.

# Delete pause container and watch new pause container will be created and observe the IP address of the pod got changed.
