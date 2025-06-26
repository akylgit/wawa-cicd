# 1. Data sources first (default VPC, subnet, SG)
data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }

  filter {
    name   = "availability-zone"
    values = ["us-east-1a"]
  }

  filter {
    name   = "default-for-az"
    values = ["true"]
  }
}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = data.aws_vpc.default.id
}

# 2. Then resource(s) that depend on them
resource "aws_instance" "web" {
  count                  = 1
  ami                    = "ami-0a7d80731ae1b2435"
  instance_type          = "t2.micro"
  key_name               = "devops-key"
  subnet_id              = data.aws_subnet.default.id
  vpc_security_group_ids = [data.aws_security_group.default.id]

  tags = {
    Name = "WawaSimpleEC2-${count.index + 1}"
  }
}
