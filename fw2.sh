# IPs
LB="$(neutron lbaas-loadbalancer-show lb | awk 'FNR == 14 {print $4}')"

# Rules creation
openstack firewall group rule create --protocol tcp --destination-port 80 --destination-ip-address "${LB}" --action allow --name fw_rule_lb
openstack firewall group rule create --protocol tcp --destination-port 22 --destination-ip-address 10.100.0.10 --action allow --name fw_rule_admin
openstack firewall group rule create --protocol any --source-ip-address 10.100.0.0/24 --action allow --name fw_rule_int_1
openstack firewall group rule create --protocol any --source-ip-address 10.200.0.0/24 --action allow --name fw_rule_int_2

# Policy creation
openstack firewall group policy create --firewall-rule "fw_rule_lb"  myfw

# Create firewall group
openstack firewall group create --ingress-firewall-policy "myfw" --no-port 

# Adding new rules
openstack firewall group policy add rule myfw "fw_rule_admin"
openstack firewall group policy add rule myfw "fw_rule_int_1"
openstack firewall group policy add rule myfw "fw_rule_int_2"
