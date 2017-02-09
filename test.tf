#
# PROVIDERS
#
provider "aws" {
    region = "us-east-1"
}

provider "alks" {
    url      = "https://uat.alks.coxautoinc.com/rest"
    account  = "120678615247/ALKSAdmin - awsaepnp"
    role     = "Admin"
}

# CREATE IAM ROLE
resource "alks_iamrole" "mah_role" {
    name                     = "My_Test_Role8"
    type                     = "Amazon EC2"
    include_default_policies = false
}

# ATTACH POLICY
resource "aws_iam_role_policy" "test_policy" {
    name     = "test_policy"
    role     = "${alks_iamrole.mah_role.name}"
    policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

# CREATE SECURITY GROUP TO TEST NON-IAM
resource "aws_security_group" "btest" {
    name   = "btest2"

    egress {
        from_port   = 0
        to_port     = 0 
        protocol    = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
}