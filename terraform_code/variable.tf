variable "instance_type" {
    type = list(string)
    default = [ "t2.medium", "t2.micro", "t2.micro" ]
}
variable "instance_name" {
    type = list(string)
    default = [ "Jenkins-master", "Build-slave", "Ansible-server" ]

}