provider "vault" {
    address = "http://127.0.0.1:8200"
    token = "11ff0bb4-13f6-3d50-29eb-9754c00fbfd4"
  
}

resource "vault_secret" "aws" {
    path = "/aws/cred/deploy"
}

# Assuming a Vault entry with the following fields:
#   access_key
#   secret_key

provider "aws" {
    access_key = "${vault_secret.aws.data.access_key}"
    secret_key = "${vault_secret.aws.data.secret_key}"
    region = "ap-southeast-1"
}


resource "aws_instance" "example" {
  ami = "ami-77af2014"
  instance_type = "t2.micro"

  tags {

    Name = "terraform-example"
 }
}

resource "aws_iam_server_certificate" "test_cert" {
  
  name             = "example_self_signed_cert"
  certificate_body = "${tls_self_signed_cert.example.cert_pem}"
  private_key      = "${tls_private_key.example.private_key_pem}"
    
    }


