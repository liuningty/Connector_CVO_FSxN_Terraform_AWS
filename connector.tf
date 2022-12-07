# create bluexp connector instance 
resource "netapp-cloudmanager_connector_aws" "bluexp_connector_aws" {
  provider      = netapp-cloudmanager
  name          = "ConnectorTF01"
  region        = var.region
  key_name      = aws_key_pair.connector_key_pair.key_name
  company       = "NetApp"
  instance_type = "t3.xlarge"
  aws_tag {
    tag_key   = "Deployment"
    tag_value = "Terraform Automation"
  }
  subnet_id                 = aws_subnet.subnet_1.id
  security_group_id         = aws_security_group.sg_bluexp.id
  iam_instance_profile_name = aws_iam_instance_profile.connector_iam_role.name
  account_id                = var.account
  # make sure connector to be deleted before the following resources get deleted when terraform destroy, so connector has required network and permissions to be able to delete cvo
  depends_on = [aws_iam_role_policy_attachment.connector_iam_role_attachment_1, aws_iam_role_policy_attachment.connector_iam_role_attachment_2, aws_main_route_table_association.set-default-rt-assoc]
}