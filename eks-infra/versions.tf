terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.15.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
		helm = {
			source  = "hashicorp/helm"
			version = "~> 2.0.1"
		}
  }
  required_version = "0.15.2"
}

