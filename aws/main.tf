provider "aws" {
  profile = "default"
  region  = "ap-northeast-1"
}

variable "APP_NAME" {
  type = string
  default = tskt
}

variable "PUB_KEY" {
  type = string
}