provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}
resource "aws_s3_bucket" "iwayq-s3-bucket" {
  bucket = "iwayq-terraform-state"
  acl    = "private"
  region = "${var.region}"

  tags = {
    Name        = "iwayq-terraform-state"
    Environment = "Prod"
  }
}

resource "aws_dynamodb_table" "terraform_statelock" {
  name           = "iwayq-dynamodb-lock-state"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}