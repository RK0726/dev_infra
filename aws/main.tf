provider "aws" {
  profile = "default"
  region  = "ap-northeast-1"
}

variable "app_name" {
  type    = string
}

variable "pub_key" {
    type = string
}