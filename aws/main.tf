terraform {
  backend "s3" {
    bucket = "tskt-terraform"
    region = "ap-northeast-1"
    key = "terraform.tfstate"
    encrypt = true
  }
}

provider "aws" {
  region  = "ap-northeast-1"
}

variable "APP_NAME" {
  type = string
}

variable "KEY_NAME" {
  type = string
}