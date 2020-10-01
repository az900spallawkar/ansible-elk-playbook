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
   #key_name        = var.private_key_path
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
    private_key = file("~/jenkinskey.pem")
   # private_key = var.private_key_file
   #private_key = file(var.private_key_file)
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
    command ="ansible-playbook -u ubuntu --private-key ${var.private_key_file} -i ${aws_instance.example.public_dns}, site.yml"
     #command ="ansible-playbook -u ubuntu site.yml -i ${aws_instance.example.public_dns},"
    # command ="ansible-playbook -u ubuntu --key-file /var/lib/jenkins/jenkinskey.pem -i ${aws_instance.example.public_dns}, site.yml"
     connection {
    type        = "ssh"
    user        = "ubuntu"
   # private_key = ${var.jenkins_ssh}
      private_key = file("~/jenkinskey.pem")
    #private_key = var.private_key_file
  #private_key = file(var.private_key_file)
    host        = aws_instance.example.public_ip
     
     }
  }
  }
