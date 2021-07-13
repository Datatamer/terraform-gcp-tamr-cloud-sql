terraform {
  required_version = ">= 0.14"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 3.18.0, <= 4.0.0"
    }
  }
}
