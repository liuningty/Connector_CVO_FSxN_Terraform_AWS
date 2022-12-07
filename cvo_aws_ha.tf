/*
# create CVO HA deployment
resource "netapp-cloudmanager_cvo_aws" "cvo_ha_aws_tf" {
  provider = netapp-cloudmanager
  name     = "TerraformCVOHA"
  region   = var.region
  vpc_id   = aws_vpc.vpc_bluexp.id
  aws_tag {
    tag_key   = "Deployment"
    tag_value = "Terraform"
  }
  aws_tag {
    tag_key   = "instance"
    tag_value = "CVO HA"
  }
  svm_password       = "Netapp1!"
  client_id          = netapp-cloudmanager_connector_aws.bluexp_connector_aws.client_id
  is_ha              = true
  failover_mode      = "FloatingIP"
  node1_subnet_id    = aws_subnet.subnet_1.id
  node2_subnet_id    = aws_subnet.subnet_2.id
  mediator_subnet_id = aws_subnet.subnet_3.id
  mediator_key_pair_name = aws_key_pair.connector_key_pair.key_name
  cluster_floating_ip = "192.168.1.10"
  data_floating_ip = "192.168.1.11"
  data_floating_ip2 = "192.168.1.12"
  svm_floating_ip = "192.168.1.13" 
  route_table_ids = [aws_route_table.internet_route_bluexp.id]
}
*/