provider "vault" {
    address = "http://127.0.0.1:8200"
    token = "a8ab4d6d-f2ca-4a29-b088-7a5a078b4864"
  
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

resource "vault_secret" "cert" {
    path = "/root/certs"
}

# Assuming a Vault entry with the following fields:
#   cert
#   key
resource "aws_iam_server_certificate" "www" {
    
    certificate_body = "/root/certs/site.key"
    private_key = "/root/certs/ap-southeast-1-test.pem"
}


