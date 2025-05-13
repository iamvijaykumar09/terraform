terraform {
    backend  "s3" {
        bucket = "my-terraform-state-bucket"
        key = "terraform/state"
        region = "ap-southeast-1"
        encrypt = true
        dynamodb_table = "terraform-locks-dynamodb"
    }
}