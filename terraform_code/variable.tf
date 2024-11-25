variable "instance_config" {
   type = map(string)
   default = {
     "Jenkins-master" = "t2.medium"
     "Build-slave" = "t2.micro"
     "Ansible-server" = "t2.micro"
   }
}
