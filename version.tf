terraform {
  required_version = ">= 1.0.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 3.18.0, <5.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "> 3.0.0"
    }
  }
}
