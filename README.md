# terraform-ckan-aws

## What do you need?
- An instance of `aws-cli` configured in your local machine, instructions can be found [here](https://aws.amazon.com/cli/)
  - Obs: For that you are going to need to create an `IAM` user, so that you can provide `aws-cli` with an `access` and `secret` key, instructions can be found [here](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users.html)
- The `terraform` software installed on your computer
- `kubectl` installed, but mostly so you can see your work

## Making the kubernetes cluster

Most of this section is taken from this [tutorial](https://learn.hashicorp.com/tutorials/terraform/eks?in=terraform/kubernetes).   
Just go to the `eks-infra` directory first then
```
terraform init
```
This will init terraform on your project and create a `versions.tf` file
```
terraform apply
```
This will apply the changes from your terraform config, and actually create the resources in your AWS account   
The output should be something like this
```
Outputs:

cluster_endpoint = "......"
cluster_id = "....."
cluster_name = "....."
cluster_security_group_id = "...."
region = "us-east-2"
```
After that you probably want to get a way to access this cluster
```
aws eks --region $(terraform output -raw region) update-kubeconfig \
    --name $(terraform output -raw cluster_name)
```
This command will allow you to do stuff such as, 
```
kubectl cluster-info
kubectl get nodes
...
```
## Installing ckan on it

Now go to the other file `helm-infra`

Just do
```
terraform init
```
And
```
terraform apply
```
If everything goes accordingly you shoud be able to see some resources such as `ckan` `db` and `datapusher` being created, you can access those with   
```
kubectl port-forward {name of the pod} {port of the pod}:{port in your localhost}
```
