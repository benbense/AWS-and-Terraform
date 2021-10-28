data "aws_ami" "ubuntu" {
    most_recent = true
    owners = ["099720109477"]
    filter {
      name = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64*"]
    }
}

data "aws_s3_bucket" "main_bucket" {
  bucket = "ben-opsschool"
}