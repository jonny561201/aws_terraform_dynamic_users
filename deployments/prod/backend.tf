terraform {
  backend "s3" {
    bucket = "prod-coaching-classroom-user-statefile"
    key    = "statefile"
    region = "us-east-1"
    endpoint = ""
  }
}