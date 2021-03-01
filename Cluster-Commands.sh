# Kubectl auto completion
sudo yum install bash-completion
source /usr/share/bash-completion/bash_completion
echo 'source <(kubectl completion bash)' >>~/.bashrc

# Exit from session and connect back.

# Check the helath of the cluster components.
kubectl get componentstatuses

# Check cluster information
kubectl cluster-info

# Dump cluster info
kubectl cluster-info dump

# Check nodes information
kubectl get nodes
kubectl get nodes -o wide

# Check node labels
kubectl get nodes --show-labels

# Describe nodes
kubectl describe nodes master.k8slocal.com


# Check cluster resources
kubectl get all -n kube-system

# Shwo labels of kube-system pods
kubectl get pods --show-labels -n kube-system

# List pods based on the labels
kubectl get pods -n kube-system -l=component=kube-scheduler

# List pods wide informaion
kubectl get pods -n kube-system -l=component=kube-scheduler -o wide

# To print control-plane pods
kubectl get pods -n kube-system --show-labels
kubectl get pods -n kube-system -o wide -l=tier=control-plane


# To print services in kube-system namespace
kubectl get services -n kube-system

# Print labels of kube-system services
kubectl get services -n kube-system -o wide
kubectl get services -n kube-system -o wide --show-labels


# Deployments
kubectl get deployments -n kube-system
kubectl get deploy -n kube-system -o wide
kubectl get deploy -n kube-system -o wide --show-labels

# Daemonsets
kubectl get daemonsets.apps -n kube-system
kubectl get daemonsets.apps -n kube-system -o wide
kubectl get daemonsets.apps -n kube-system -o wide --show-labels

# Replicasets
kubectl get replicasets -n kube-system
kubectl get replicasets -n kube-system -o wide
kubectl get replicasets -n kube-system -o wide --show-labels

