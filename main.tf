terraform {
  required_providers {
    netapp-cloudmanager = {
      source  = "NetApp/netapp-cloudmanager"
      version = "22.10.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "4.45.0"
    }
  }
}

provider "netapp-cloudmanager" {
  refresh_token = var.token
}

provider "aws" {
  profile = var.profile
  region  = var.region
}