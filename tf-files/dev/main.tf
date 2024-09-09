terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "contactlist-backend-cigdemb"
    key = "env/dev/tf-remote-backend.tfstate"
    region = "us-east-1"
    dynamodb_table = "tf-s3-app-lock"
    encrypt = true
  }
}


module "contactlist" {
  source   = "../modules"
  git-user = "cigdemb"
  key-name = "ec2-key"
  hosted-zone = "cigdemb.com"
  env = "dev"
}

output "websiteurl" {
  value = module.contactlist.websiteurl
}
