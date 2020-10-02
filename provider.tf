terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket = "terraform-bucket-saziya"
    key    = "terraform.tfstate"
    region = "eu-west-2"
  }
}

provider "aws" {
  profile = "default"
  region  = "eu-west-2"
}


#variable "jenkins_ssh" {
#  description = "SSH key passed in by Jenkins"
#}

#locals {
 #  ssh_private_key_content = file(var.ssh_private_key_file)
#   }
  


#variable "key_name" {default="my-key11"}
#resource "tls_private_key" "example" {
 # algorithm = "RSA"
#  rsa_bits  = 4096
#}
#resource "aws_key_pair" "generated_key" {
#  key_name   = var.key_name
#  public_key = tls_private_key.example.public_key_openssh
#}

#resource "aws_key_pair" "ubuntu" {
#  key_name   = "ubuntu"
#  public_key = file(var.public_key_path)
  
 # }
#resource "aws_key_pair" "terraform" {
#  key_name = ""
#  public_key = "terraform.pub"
#}

resource "aws_security_group" "test_sg" {
  name = "test_sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow outgoing traffic to anywhere.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#resource "aws_key_pair" "deployer" {
#  key_name   = "jenkinskey"
  #public_key = "~/.ssh/authorized_keys"
#  public_key = "file(/home/ubuntu/.ssh/authorized_keys)"
#  }

resource "aws_instance" "example" {
  # key_name         = aws_key_pair.terraform-ansible.key_name
  # key_name      = aws_key_pair.deployer.key_name
   #key_name        = var.private_key_file
  key_name        = "jenkinskey"
   ami              = "ami-0287acb18b6d8efff"
   instance_type    = "t2.micro"
   security_groups  = ["${aws_security_group.test_sg.name}"]


  provisioner "remote-exec" {
    inline = ["echo 'Hello World'"]
    
    connection {
    type        = "ssh"
    user        = "ubuntu"
   # private_key = ${var.jenkins_ssh}
    #private_key = file("/var/lib/jenkins/jenkinskey")
   #private_key = "$(var.private_key_file)"
   #private_key = file("${var.private_key_file}")
      private_key = "-----BEGIN RSA PRIVATE KEY-----
MIIEogIBAAKCAQEApVVeRYF/h5XGVb/5g2J/W4T01cEtGMKnWc3LHKmTaXKlDrRCYNGtu8P/oo6+
VVWComQfuu3RgtV75lB0UdUdbYQSo3xUQYMQ7lut62tr7UQCLThu5R34XCZbsVNiu4yMptUvietG
wdsVFxHom6i/tbmRqT3Wn1IEsj1onVQRXAWiu51xj2XuWCBhRit9zK8I7P2cL4dZnSC3ASAtHCJL
NuZStm6+qM3PJjQd66tCt87rWZ1aueAtlxGzUwIfm6V1F6GQsGqb/MQKa8FvWHapK4Orm+1H5c40
dUXbTy0PMS0O/FdMWP52jncGG/t45N9vrhGkB65NngWUnBGLmjrflQIDAQABAoIBADPyztwoBFol
xVvMJioSGNI4xHUlbXYKM2sULm2jGp5XV2V3XiPtvhjxTLFXCJbnd1RvAUlK0Dm7umJzhRjxTX3L
sc+MkSzEcd1zEQKXjiHO7KAoyy9Sa2cI5mahPLSRROBmu7kqI+FlZQsKpXvDWflPhWUX+Qe2TaNz
iBtm/s1atpue6y94WG5g8o6ePZlrkbabdgqhLwEhXmSnQ/Q/ZIEw0N1Y99+CHrBlMBrmZhKfqHN3
abAyUWxSHOf0gXr3p3N9lxuZNmWMcCLvvdO236rtGR3BxoQjZSXbB/Am0i91g9VIdAMMIpy8GUIg
vgvDu1uJun7PR2/Q69lJBySZMgECgYEA1LhHvSq8VWTmRg6D5NMoIOy57utcx0kZGa6sYZMlN/N/
dtBwlwls+dIZFweddH66Gh6jp7DMyBH7q8JSHqaNjwDSqYPYBbP4jYCQte5+SBh2DzrcaA/S02mS
C92kRBMm2mJSp2ZXwqYf/Zyf69F7UjYFA6B4r/WTIj/E6vAkxA0CgYEAxvjsMlMdRCFCDRmb6KSt
KGvpNqON6G2vTa6tX2H1zjvG6HPk0/lcesrO1lrsLWPGtL9A8f77G/B0ZexeVRqS/tCHj4nbww4U
nfInXawmSS69/ueYFN81JaeltwmEyT++W3RFX8hH80AThwcXH4S/uZ/Evogbew77WipPzgu/f6kC
gYBJ0opTA/nISPQBbBgp2X4brwv39oaEQsILP6tjUYWhHUgnG793KzY+nMNIUsQ6IaDEX8277Iel
B1ioCxAkwvhtoIN7gN3/XK3traiK+vGoY5TVREApfRRVelXM+GaBmYPqViUJI2NhkfWYNjrpxBFg
Po8O6yn3JuqhADB+uEiKIQKBgB7KmtLW5eqLMwuP8P65rUpaGMcp3GYhw0VESPQ/1qhJu+hxNvJO
3q7p/8RQYchMbo2+IzDQAtA6D+lOAPMun5zrbG8cKHQxE6O1u73VTD97ClAOSwy/1huzrAN9Z501
TiIdBjdiaTANtHfq8vsfsgPp46qQqaALm35CmgMK8mGxAoGAWrmWTsEaGUT8B5vqj/+sXb7iX8gr
AQow+kH/pdDl0jvxKj8dmI5maKYKd09QfOGvS1qJFUdrW5HJSd45J5u5A1J/Gr51RbtQZ7llR5IF
IGYv5npskmlrArXhglpM5Bq5JC07jQuDdaNT9ErFfPbTtt0Enyvv4nwcLGPDEbTJPmU=
-----END RSA PRIVATE KEY-----"
    host        = aws_instance.example.public_ip
  
 # host            = self.ipv4_address
       }
 

    }
  #  connection {
   #   type        = "ssh"
   #   user        = var.ssh_user
   #   private_key = file(var.private_key_path)
    #  host        = self.public_ip
    #  }
   # }
 # connection {
 #   type        = "ssh"
  #  user        = "ubuntu"
   # private_key = file("var.private_key_path")
   # private_key = tls_private_key.example.private_key_pem
   # private_key  = var.private_key_path
   #  private_key  = local.ssh_private_key_content
   # host        = self.public_ip
   # host        = aws_instance.example.public_dns
  #}
    
   provisioner "local-exec" {
     
  # command = "sleep 120; ansible-playbook host_key_checking=false -u ubuntu --private-key ${var.private_key_path} -i '${aws_instance.example.public_dns},' site.yml"
  # command = "ansible-playbook ANSIBLE_HOST_KEY_CHECKING=False -u ubuntu -i '${aws_instance.example.public_dns},' --private-key ${tls_private_key.example.private_key_pem} site.yml"
  # command = "ansible-playbook ANSIBLE_HOST_KEY_CHECKING=False -u ubuntu --prviate-key ${var.jenkins_ssh} -i '${aws_instance.example.public_dns},' site.yml"
  # command = "ansible-playbook -u ubuntu --private-key $(var.private_key_path) -i '${aws_instance.example.public_dns},' site.yml"
    #command ="ansible-playbook -u ubuntu --private-key ${var.private_key_file} -i ${aws_instance.example.public_dns}, site.yml"
     command ="ansible-playbook -u ubuntu site.yml -i ${aws_instance.example.public_dns},"
    # command ="ansible-playbook -u ubuntu --key-file /var/lib/jenkins/jenkinskey.pem -i ${aws_instance.example.public_dns}, site.yml"
     connection {
    type        = "ssh"
    user        = "ubuntu"
   # private_key = ${var.jenkins_ssh}
     # private_key = file("/var/lib/jenkins/jenkinskey.pem")
    #private_key = var.private_key_file
  private_key = file("${var.private_key_file}")
    host = aws_instance.example.public_ip
     
     }
  }
  }
