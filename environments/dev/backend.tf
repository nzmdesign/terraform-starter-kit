terraform {
  backend "s3" {
    bucket       = "terraform-starter-kit-211125779837-dev-tfstate"
    key          = "bootstrap/dev/terraform.tfstate"
    region       = "ap-northeast-1"
    use_lockfile = true
    encrypt      = true
  }
}