# Creación LB
neutron lbaas-loadbalancer-create --name lb subnet1

openstack security group create lbaasv2
openstack security group rule create --protocol icmp --ingress lbaasv2
openstack security group rule create --protocol tcp --dst-port 80:80 lbaasv2

openstack port set --security-group lbaasv2 $(openstack security group show lbaasv2 -c id -f value)  # Usar grep

# openstack port set --security-group lbaasv2 req-50035642-d266-403b-a428-3368a32f1c52

neutron lbaas-listener-create --name lb-http --loadbalancer lb --protocol HTTP --protocol-port 80

# Create pool and use Round Bobin
neutron lbaas-pool-create --name lb-http-pool --lb-algorithm ROUND_ROBIN --listener lb-http --protocol HTTP


S1="$(openstack server show app_server_1 -c addresses -f value | awk 'FNR == 1 {print $2}' | awk -F "=" '{print $2}')"
S2="$(openstack server show app_server_2 -c addresses -f value | awk 'FNR == 1 {print $2}' | awk -F "=" '{print $2}')"
S3="$(openstack server show app_server_3 -c addresses -f value | awk 'FNR == 1 {print $2}' | awk -F "=" '{print $2}')"

# Add members to pool
neutron lbaas-member-create --name lb-member-01 --subnet subnet1 --address "${S1}" --protocol-port 80 lb-http-pool
neutron lbaas-member-create --name lb-member-02 --subnet subnet1 --address "${S2}" --protocol-port 80 lb-http-pool 
neutron lbaas-member-create --name lb-member-03 --subnet subnet1 --address "${S3}" --protocol-port 80 lb-http-pool 
