cd /mnt/tmp
/mnt/vnx/repo/cnvr/bin/get-openstack-tutorial.sh
cd openstack_lab-stein_4n_classic_ovs-v05
sudo vnx -f openstack_lab.xml -v --create
sudo vnx -f openstack_lab.xml -v -x start-all
sudo vnx -f openstack_lab.xml -v -x load-img
sudo vnx_config_nat ExtNet enp2s0
#sudo vnx -f openstack_lab.xml -v -x create-demo-scenario
glance image-create --name "db-image" --file ../OpenstackScenarioCNVR/db.raw --disk-format raw --container-format bare --visibility public --progress


############################
source bin/admin-openrc.sh

openstack network create --share --external --provider-physical-network provider --provider-network-type flat ExtNet
openstack subnet create --network ExtNet --gateway 10.0.10.1 --dns-nameserver 10.0.10.1 --subnet-range 10.0.10.0/24 --allocation-pool start=10.0.10.100,end=10.0.10.200 ExtSubNet
