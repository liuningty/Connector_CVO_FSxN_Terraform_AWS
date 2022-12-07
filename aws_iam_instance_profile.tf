# create instance profile used by associating IAM role to connector instance
resource "aws_iam_instance_profile" "connector_iam_role" {
  name = "connector_iam_role"
  role = aws_iam_role.connector_iam_role.name
}