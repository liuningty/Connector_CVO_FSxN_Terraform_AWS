# Connector_CVO_FSxN_Terraform_AWS
Use Terraform to automate the deployment of NetApp BlueXP Connector and CVO/FSxN in AWS

- Create two IAM policies https://docs.netapp.com/us-en/cloud-manager-setup-admin/reference-permissions-aws.html#iam-policies
- Create IAM role
- Attach two policies to the role
- Create IAM instance profile using the role
- Create VPC
- Create Internet Gateway
- Create route table
- Create three subnets across three AZs
- Create security group
- Generate a Key Pair
- Provision BlueXP Connector 
- Provision single node CVO with a NFS volume
- Provision CVO HA
- Provision FSx NetApp ONTAP
