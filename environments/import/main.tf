resource "aws_instance" "bar" {
  ami           = "ami-1853ac65"
  instance_type = "t2.micro"
}

//resource "aws_instance" "foo" {
//  # (resource arguments)
//}
resource "aws_instance" "foo" {
  ami = "ami-1853ac65"
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
  }
}