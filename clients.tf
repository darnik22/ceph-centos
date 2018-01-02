resource "openstack_networking_floatingip_v2" "clients" {
  depends_on = ["openstack_compute_instance_v2.clients"]
  port_id  = "${element(openstack_networking_port_v2.clients-port.*.id, count.index)}"
  count = "${var.client_count}"
  pool  = "${var.external_network}"
}

resource "null_resource" "provision-client" {
  count = "${var.client_count}"
  depends_on = ["openstack_networking_floatingip_v2.clients"]
  connection {
    host     = "${element(openstack_networking_floatingip_v2.clients.*.address, count.index)}"
    user     = "${var.ssh_user_name}"
#    private_key = "${file(var.ssh_key_file)}"
    timeout = "300s"
    agent = true
  }
  provisioner "remote-exec" {
    inline = [
# #      "sudo apt-add-repository -y 'deb http://nova.clouds.archive.ubuntu.com/ubuntu/ xenial main restricted universe multiverse'", # if debmirror at OTC is not working
      "echo Instaling python ...",
      "sudo yum -y update",
      "sudo yum -y install python",
    ]
  }
}

resource "openstack_compute_instance_v2" "clients" {
#  depends_on = ["openstack_networking_router_interface_v2.interface"]
  count           = "${var.client_count}"
  name            = "${var.project}-client-${format("%02d", count.index+1)}"
  image_name      = "${var.image_name}"				#"bitnami-ceph-osdstack-7.0.22-1-linux-centos-7-x86_64-mp"
  flavor_name     = "${var.client_flavor_name}"
  key_pair        = "${openstack_compute_keypair_v2.otc.name}"
  availability_zone = "${var.availability_zone}"
  # security_groups = [
  #   "${openstack_compute_secgroup_v2.secgrp_ceph.name}"
  # ]

  network {
    port = "${element(openstack_networking_port_v2.clients-port.*.id, count.index)}"
    # uuid = "${var.network_id}"
    # access_network = true
  }
}

resource "openstack_networking_port_v2" "clients-port" {
  count              = "${var.client_count}"
  network_id         = "${var.network_id}"
  security_group_ids = [
    "${openstack_compute_secgroup_v2.secgrp_ceph.id}",
  ]
  admin_state_up     = "true"
  fixed_ip           = {
    subnet_id        = "${var.subnet_id}"
  }
}

