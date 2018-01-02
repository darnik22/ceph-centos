# Terraform files for creating a Ceph cluster on OTC on Centos VMs with IB

## Configuring
In order to build your Ceph cluster you need to:
* run ssh-agent and add your key. It will further be used to login into the created VMs.
* provide your openstack credentials by editting parameter.tvars. The username should be the same as shown in the OTC console. You can not use the email or mobile number, which can also be used to login to the OTC web console. 
* eventually change values in varaibles.tf according to the comments in this file.

Edit variables.tf and set at least the following vars:
* project - project name. It is used to prefix VM names. It should be unique among OTC as it is used to create names of VMs. The provider will have the following FQDN: ${project}-op-01.${dnszone} publicly accessible.

The variables can also be provided interactively or set as command line args. For example:
```
terraform apply -var project=example_project -var email=joe@example.com ....
```

## Running
Build your Ceph cluster issuing:
```
terraform init
terraform apply -var-file parameter.tvars
```
## Accessing your Ceph cluster
After a successful built the public IP of the cluster management node is displayed. Use it to login:
```
ssh -A linux@THE_IP
```

Check that Ceph is running:
```
sudo ceph -s
```

## Example command flow
```
eval `ssh-agent`
ssh-key
git clone https://github.com/darnik22/ceph-tf.git
cd ceph-tf
vi parameter.tvars
vi variables.tf
terraform init
terraform apply -var-file parameter.tvars
ssh -A ubuntu@THE_IP_OF_MGT_NODE
sudo ceph -s
```






