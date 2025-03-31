terraform {
  backend "s3" {
    bucket         = "terraform-aws-iac-bucket"  # Replace with your bucket name
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    # dynamodb_table = "terraform-lock"  # If using DynamoDB for state locking
  }
}
