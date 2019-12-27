sleep 5
neutron lbaas-listener-create --loadbalancer lb1 --protocol HTTP --protocol-port 80 --name listener1
sleep 5
neutron lbaas-pool-create --lb-algorithm ROUND_ROBIN --listener listener1 --protocol HTTP --name pool1
sleep 2
neutron lbaas-member-create --name lb-s1 --subnet Subnet1 --address $IP_S1 --protocol-port 80 pool1
#neutron lbaas-member-create --name lb-s2 --subnet Subnet1 --address $IP_S2 --protocol-port 80 pool1
neutron lbaas-healthmonitor-create --delay 10 --type HTTP --max-retries 3 --timeout 10 --pool pool1 --name hm1