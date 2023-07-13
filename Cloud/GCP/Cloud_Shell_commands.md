### Create instance

`gcloud compute instances create gcelab2 --machine-type e2-medium --zone us-east1-b`
`gcloud compute instances create --help`

### set region

`gcloud config set compute/region us-east1`
`gcloud config set compute/zone us-east1-b`

### set project

`gcloud config set project gcelab2`

### Create GKE cluster

`gcloud container clusters create --machine-type=e2-medium lab-cluster --num-nodes=1 --zone=us-east1-b`

### Get GKE credentials

`gcloud container clusters get-credentials lab-cluster --zone=us-east1-b`

### create instance template

`gcloud compute instance-templates create gcelab2 --machine-type=e2-medium --image-family=debian-9 --image-project=debian-cloud --boot-disk-size=10GB --boot-disk-type=pd-standard --boot-disk-device-name=gcelab2 --metadata-from-file startup-script=Cloud_Shell_commands.md`

### create firewall rule

`gcloud compute firewall-rules create allow-ssh --allow tcp:22`
`gcloud compute firewall-rules create fw-allow-health-check \
  --network=default \
  --action=allow \
  --direction=ingress \
  --source-ranges=130.211.0.0/22,35.191.0.0/16 \
  --target-tags=allow-health-check \
  --rules=tcp:80`


### read cloud function logs 

`gcloud beta functions logs read hello-world --limit=100`

### Create VPC

`gcloud compute networks create privatenet --subnet-mode=custom`

### Create subnet

`gcloud compute networks subnets create privatesubnet-us --network=privatenet --region=us-east1 --range=172.16.0.0/24`