neutron firewall-rule-create --name fw-rule-web --protocol tcp --destination-port 80 --destination-ip-address $IP_LB --action allow
neutron firewall-rule-create --name fw-rule-adm --protocol tcp --destination-port 4444 --destination-ip-address $IP_ADM --action allow
neutron firewall-rule-create --name fw-rule-int --protocol any --source-ip-address 10.1.1.0/24 --action allow
neutron firewall-policy-create --firewall-rules "fw-rule-web fw-rule-int" fw-policy1
neutron firewall-create --name fw1 --router r0 fw-policy1