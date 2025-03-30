provider "aws" {
  region = var.aws_region
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.19.0"
  
}

resource "aws_instance" "wordpress" {
  ami           = "ami-072e42fd77921edac" # Amazon Linux 2 (Change for your region)
  instance_type = "t2.micro"
  subnet_id     = element(module.vpc.public_subnets, 0)

  tags = {
    Name = "WordPress-Instance"
    Terraform = "true"
    Environment = "dev"
  }
}
