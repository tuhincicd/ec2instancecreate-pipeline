


resource "aws_instance" "example" {
  ami = "ami-77af2014"
  instance_type = "t2.micro"

  tags {

    Name = "terraform-example"
 }
}



