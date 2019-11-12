#install helm

# installs helm with bash commands for easier command line integration
curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get | bash

# add a service account within a namespace to segregate tiller
kubectl --namespace kube-system create sa tiller

# create a cluster role binding for tiller
kubectl create clusterrolebinding tiller \
    --clusterrole cluster-admin \
    --serviceaccount=kube-system:tiller

echo "initialize helm"
# initialized helm within the tiller service account
helm init --service-account tiller
# updates the repos for Helm repo integration
helm repo update

echo "verify helm"
# verify that helm is installed in the cluster
kubectl get deploy,svc tiller-deploy -n kube-system

###########
Installing mongodb using helm

helm repo add bitnami https://charts.bitnami.com/bitnami

help repo update

# this is specifically for countly
kubectl create ns countly
kubectl config set-context --current --namespace=countly

# install mongo (have created these resource files)
kubectl apply -f mongo/storage-class.yaml
helm install --name mongo -f mongo/values.yaml stable/mongodb-replicaset



############### Countly
# Create a namespace
 kubectl create ns countly
 kubectl config set-context --current --namespace=countly

 # Install MongoDB
 kubectl apply -f mongo/storage-class.yaml
 helm install --name mongo -f mongo/values.yaml stable/mongodb-replicaset

 ## Wait ~ 3 minutes until all 3 replica set pods spin up
 kubectl get po


 # Install Countly deployments & services
 kubectl apply -f countly-frontend.yaml
 kubectl apply -f countly-api.yaml

 # Install Countly ingress
 gcloud compute addresses create countly-static-ip --global

### after getting IP
gcloud compute addresses list


## edit detaisl
kubectl apply -f countly-ingress-gce.yaml
