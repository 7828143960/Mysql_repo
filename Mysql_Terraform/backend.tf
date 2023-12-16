terraform {

  backend "s3" {

    bucket         = "jaiswalbucket00"

    key            = "mysql/terraform.tfstate"

    region         = "ap-south-1"

    dynamodb_table = "dynamodb_table"

    encrypt        = true

  }

}
