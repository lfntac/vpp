variable "auth_token" {}
variable "project_id" {}
variable "public_key" {}
variable "worker_hostname" {}
variable "public_key_name" {}

provider "packet" {
  auth_token = "${var.auth_token}"
}

resource "packet_ssh_key" "key" {
  name       = "${var.public_key_name}"
  public_key = "${file(var.public_key)}"
}

resource "packet_device" "worker" {
  hostname         = "${var.worker_hostname}"
  facilities       = ["sjc1"]
  plan             = "t1.small.x86"
  operating_system = "ubuntu_16_04"
  billing_cycle    = "hourly"
  project_id       = "${var.project_id}"
  depends_on       = ["packet_ssh_key.key"]
}

output "worker.public_ip" {
  value = "${packet_device.worker.access_public_ipv4}"
}

