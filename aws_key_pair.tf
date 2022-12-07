# create key-pair for logging into connector instance
resource "aws_key_pair" "connector_key_pair" {
  key_name   = "connector_key_pair"
  public_key = file("~/.ssh/id_rsa.pub")
}