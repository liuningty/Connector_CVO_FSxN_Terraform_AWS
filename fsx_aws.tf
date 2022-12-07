/*
# create FSx for ONTAP 
resource "netapp-cloudmanager_aws_fsx" "aws_fsx" {
  provider            = netapp-cloudmanager
  name                = "TerraformAWSFSX"
  region              = var.region
  primary_subnet_id   = aws_subnet.subnet_1.id
  secondary_subnet_id = aws_subnet.subnet_2.id
  tenant_id           = var.account
  workspace_id        = var.workspace
  tags {
    tag_key   = "Depolyment"
    tag_value = "By Terraform"
  }
  fsx_admin_password         = "Netapp1!"
  throughput_capacity        = 512
  storage_capacity_size      = 1024
  storage_capacity_size_unit = "GiB"
  aws_credentials_name       = var.bluexp_cred
}
*/