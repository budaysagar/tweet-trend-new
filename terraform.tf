terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.77.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.6"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.5.2"
    }
  }
}