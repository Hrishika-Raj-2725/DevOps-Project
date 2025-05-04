provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "smart_monitor" {
  ami           = "ami-0f58b397bc5c1f2e8"
  instance_type = "t2.micro"
  key_name      = "key-name-jenkins"
  tags = {
    Name = "SmartEnergyMonitor"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("/mnt/c/Users/hrish/Downloads/key-pair-jenkins.pem")
      host        = self.public_ip
    }
  }
}

output "instance_ip" {
  value = aws_instance.smart_monitor.public_ip
}
