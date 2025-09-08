module "frontend" {

  source = "terraform-aws-modules/ec2-instance/aws"

  count = 2
 
  ami                    = "ami-0fd3ac4abb734302a" # Valid Ubuntu AMI

  instance_type          = "t2.micro"

  subnet_id              = aws_subnet.public[count.index].id

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  key_name      = "docker"
 
  

  # Corrected: Create a unique name for each instance

  name = "web-${count.index}"
 
  tags = {

    Terraform   = "true"

    Environment = "dev"

    Name        = "web-${count.index}"

  }

}
 
resource "null_resource" "install_nginx_1" {

count = 2
   
 provisioner "remote-exec" {

    inline = [

      "set -e",

      "sudo yum install nginx -y",

      "sudo systemctl start nginx",

      "sudo systemctl enable nginx",

      "sudo mkdir -p /usr/share/nginx/html",

      # No extra location needed, / path serves this

      "sudo systemctl restart nginx"

    ]
 
    connection {

      type        = "ssh"

      host        = module.frontend[count.index].public_ip

      user        = "ec2-user"

      private_key = file("docker.pem")

    }

  }

}
 