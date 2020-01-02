# Creación LB
neutron lbaas-loadbalancer-create --name lb subnet1

openstack security group create lbaasv2
openstack security group rule create --protocol icmp --ingress lbaasv2
openstack security group rule create --protocol tcp --dst-port 80:80 lbaasv2

openstack port set --security-group lbaasv2 d5d89d1e-c47b-4e74-b5d8-9809f46050fb  # Usar grep

neutron lbaas-listener-create --name lb-http --loadbalancer lb --protocol HTTP --protocol-port 80

# Create pool and use Round Bobin
neutron lbaas-pool-create --name lb-http-pool --lb-algorithm ROUND_ROBIN --listener lb-http --protocol HTTP

# Add members to pool
neutron lbaas-member-create --name lb-member-01 --subnet subnet1 --address 192.168.100.41 --protocol-port 80 lb-http-pool # usar grep