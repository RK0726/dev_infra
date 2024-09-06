provider "aws" {
  region  = "ap-northeast-1"
}

variable "APP_NAME" {
  type = string
}

variable "KEY_NAME" {
  type = string
}