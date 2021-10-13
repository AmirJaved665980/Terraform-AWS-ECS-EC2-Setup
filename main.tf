terraform {
  backend "s3" {
    bucket         = "<projectName>-devops-tfstate"
    key            = "project.tfstate"
    region         = "<AWSRegion>"
    encrypt        = true
    dynamodb_table = "<projectName>-devops-tfstate-lock"
  }
}

provider "aws" {
  region  = "eu-central-1"
  version = "~> 2.54.0"
}


locals {
  prefix = "${var.prefix}-${terraform.workspace}"
  common_tags = {
    Environment = terraform.workspace
    Project     = var.project
    Owner       = var.contact
    ManagedBy   = "Terraform"
  }
}

data "aws_region" "current" {}