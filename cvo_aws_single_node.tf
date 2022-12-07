# create cvo single node
resource "netapp-cloudmanager_cvo_aws" "cvo_aws_tf" {
  provider  = netapp-cloudmanager
  name      = "TerraformCVO"
  region    = var.region
  subnet_id = aws_subnet.subnet_1.id
  vpc_id    = aws_vpc.vpc_bluexp.id
  aws_tag {
    tag_key   = "instancetype"
    tag_value = "POC single instance"
  }
  aws_tag {
    tag_key   = "location"
    tag_value = "sydney"
  }
  svm_password        = "Netapp1!"
  client_id           = netapp-cloudmanager_connector_aws.bluexp_connector_aws.client_id
  writing_speed_state = "NORMAL"
}

# create a nfs volume from cvo created above
resource "netapp-cloudmanager_volume" "cvo_volume_nfs" {
  provider                  = netapp-cloudmanager
  volume_protocol           = "nfs"
  name                      = "vol1"
  size                      = 10
  unit                      = "GB"
  provider_volume_type      = "sc1"
  export_policy_type        = "custom"
  export_policy_ip          = ["0.0.0.0/0"]
  export_policy_nfs_version = ["nfs4"]
  working_environment_id    = netapp-cloudmanager_cvo_aws.cvo_aws_tf.id
  client_id                 = netapp-cloudmanager_connector_aws.bluexp_connector_aws.client_id
}