terraform {
  required_version = ">= 1.4.4"
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = ">= 4.63.0"
      configuration_aliases = [aws.useast1]
    }
  }
}
