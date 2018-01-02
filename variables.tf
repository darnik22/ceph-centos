### OpenStack Credentials
variable "otc_username" {}

variable "otc_password" {}

variable "otc_domain_name" {}

#variable "user_no" {}

variable "tenant_name" {
  default = "eu-de"
}

variable "endpoint" {
  default = "https://iam.eu-de.otc.t-systems.com:443/v3"
}

### OTC Specific Settings
variable "external_network" {
  default = "admin_external_net"
}

### Project Settings
variable "project" {
#   default = "od"
}

variable "ssh_user_name" {
#  default = "ubuntu"
  default = "linux"
}

variable "public_key_file" {
  default = "/home/ubuntu/.ssh/id_rsa.pub"
}

### VM (Instance) Settings
variable "ceph-mgt_count" {
  default = "1"
}

variable "ceph-mon_count" {
  default = "1"
}

variable "ceph-osd_count" {
  default = "3"
}

variable "flavor_name" {
#  default = "h1.large.4"
  default = "hl1.8xlarge.8" # Setting this flavor may require setting vol_type and vol_prefix
}

variable "mgt_flavor_name" {
  default = "h1.large.4"
#  default = "hl1.8xlarge.8" # Setting this flavor may require setting vol_type and vol_prefix
}

variable "image_name" {
#  default = "Community_Ubuntu_16.04_TSI_latest"
  default = "Standard_CentOS_7_134_20171211_0"
}

variable "availability_zone" {
  default = "eu-de-01"
}

variable "vol_size" {
  default = "1000"
}

variable "vol_type" {
#  default = "SSD"
  default = "co-p1"
#  default = "uh-l1"
  
}

variable "vol_prefix" {
#  default = "/dev/xvd"
  default = "/dev/vd"
}

variable "disks-per-osd_count" {
  default = "5"
}

variable "client_count" {
  default = "1"
}

variable "client_flavor_name" {
  default = "hl1.8xlarge.8" # Setting this flavor may require setting vol_type and vol_prefix
#  default = "h1.xlarge.4"
}

variable "network_id" {
  default = "a19035ee-2b07-4afc-8adb-67f81e801707"
}

variable "subnet_id" {
  default = "1a3be2ec-be4d-4a4b-8480-e3e0dd08eb5c"
}

