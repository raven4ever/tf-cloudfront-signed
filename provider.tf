terraform {
  required_version = ">=1.2"

  required_providers {
    aws = {
      sosource = "hashicorp/aws"
      version  = ">=4"
    }
  }
}

provider "aws" {

}
