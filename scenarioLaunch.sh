# Get to path
cd /mnt/tmp/openstack_lab-stein_4n_classic_ovs-v05
sudo vnx -f openstack_lab.xml -v --create
sudo vnx -f openstack_lab.xml -v -x start-all
sudo vnx -f openstack_lab.xml -v -x load-img
sudo vnx_config_nat ExtNet enp2s0

# Get admin privileges
source bin/admin-openrc.sh

# Move to scenario folder
cd ../OpenstackScenarioCNVR

# Import already downloaded IMG
glance image-create --name "db-image" --file db.raw --disk-format raw --container-format bare --visibility public --progress

# Create ExtNet
openstack network create --share --external --provider-physical-network provider --provider-network-type flat ExtNet
openstack subnet create --network ExtNet --gateway 10.0.10.1 --dns-nameserver 10.0.10.1 --subnet-range 10.0.10.0/24 --allocation-pool start=10.0.10.100,end=10.0.10.200 ExtSubNet

# Launch stack
openstack stack create -t scenario.yml -e parameters.yml pFinalStack

# Wait until fully creation
read -p "Click any key when the stack is fully created to launch LB"

# Create LB
chmod 777 lb.sh
./lb.sh
read -p "Click any key to launch FW"

# Create FW
chmod 777 fw2.sh
./fw2.sh