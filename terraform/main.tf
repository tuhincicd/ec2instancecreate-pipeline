provider "vault" {
    address = "http://127.0.0.1:8200"
    token = "df70b503-8951-d4e1-f580-32cc27df27df"
  
}

resource "vault_secret" "aws" {
    path = "/aws/creds/deploy"
}

# Assuming a Vault entry with the following fields:
#   access_key
#   secret_key

provider "aws" {
    access_key = "${vault_secret.aws.deploy.access_key}"
    secret_key = "${vault_secret.aws.deploy.secret_key}"
    region = "ap-southeast-1"
}


resource "aws_instance" "example" {
  ami = "ami-77af2014"
  instance_type = "t2.micro"

  tags {

    Name = "terraform-example"
 }
}



