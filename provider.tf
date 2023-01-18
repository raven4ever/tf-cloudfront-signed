terraform {
  required_version = ">=1.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=4"
    }

    tls = {
      source  = "hashicorp/tls"
      version = ">=4"
    }

    external = {
      source  = "hashicorp/external"
      version = ">=2"
    }

    local = {
      source  = "hashicorp/local"
      version = ">=2"
    }
  }
}

provider "aws" {
}
