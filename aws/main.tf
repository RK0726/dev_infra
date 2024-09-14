terraform {
  backend "s3" {
    bucket  = "tskt-terraform"
    region  = "ap-northeast-1"
    key     = "terraform.tfstate"
    encrypt = true
  }
}

provider "aws" {
  region = var.REGION
  default_tags {
    tags = {
      AppName = var.APP_NAME
    }
  }
}