{

kubectl create sa deployer
kubectl create clusterrolebinding deployer --clusterrole cluster-admin --serviceaccount default:deployer

KUBE_DEPLOY_SECRET_NAME=`kubectl get sa deployer -o jsonpath='{.secrets[0].name}'`
KUBE_API_EP=`kubectl get ep -o jsonpath='{.items[0].subsets[0].addresses[0].ip}'`
KUBE_API_TOKEN=`kubectl get secret $KUBE_DEPLOY_SECRET_NAME -o jsonpath='{.data.token}'|base64 --decode`
KUBE_API_CA=`kubectl get secret $KUBE_DEPLOY_SECRET_NAME -o jsonpath='{.data.ca\.crt}'|base64 --decode`
echo $KUBE_API_CA > tmp.deploy.ca.crt

export KUBECONFIG=./my-new-kubeconfig
kubectl config set-cluster k8s --server=https://$KUBE_API_EP --certificate-authority=tmp.deploy.ca.crt --embed-certs=true
kubectl config set-credentials k8s-deployer --token=$KUBE_API_TOKEN
kubectl config set-context k8s --cluster k8s --user k8s-deployer
kubectl config use-context k8s

rm tmp.deploy.ca.crt
unset KUBECONFIG

}