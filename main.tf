provider "aws" {
  region = var.aws_region
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0" 

  
  azs               = ["us-east-1a","us-east-1b"]  # List availability zones for your region
  private_subnets   = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]  # Private subnets
  public_subnets    = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]  # Public subnets
  enable_nat_gateway = true
  enable_vpn_gateway = false  # Set this as per your requirements (true/false)

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_instance" "wordpress" {
  ami           = "ami-072e42fd77921edac" # Amazon Linux 2 AMI (change for your region)
  instance_type = "t2.micro"
  subnet_id     = element(module.vpc.public_subnets, 0)

  tags = {
    Name        = "WordPress-Instance"
    Terraform   = "true"
    Environment = "dev"
  }
}

