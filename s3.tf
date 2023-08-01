terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }

  backend "s3" {
    bucket = "guru-bucket-1"
    key = "prod/terraform.tfstate"
    region = "us-east-2"
    dynamodb_table = "ddbt1"
  }
}

resource "aws_s3_bucket" "s3_bucket_1" {
  bucket = "guru-bucket-1"
}

resource "aws_s3_bucket_versioning" "s3v" {
  bucket = aws_s3_bucket.s3_bucket_1.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "ddbt1" {
  name         = "ddbt1"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "919101"
  attribute {
    name = 919101
    type = "N"
  }
}

resource "aws_instance" "ec2" {
    ami = "ami-024e6efaf93d85776"
    instance_type = "t2.micro"

    tags = {
      Name = "tf-ec2"
    }
}