# Reglas config security groups aun falta. Coger del .xml de creación del escenario




# FW

LB= # get with grep
ADMIN= # Get with grep

neutron firewall-rule-create --name fw-rule-web --protocol tcp --destination-port 80 --destination-ip-address $LB --action allow
neutron firewall-rule-create --name fw-rule-adm --protocol tcp --destination-port 4444 --destination-ip-address $ADMIN --action allow
neutron firewall-rule-create --name fw-rule-int --protocol any --source-ip-address 10.1.1.0/24 --action allow
neutron firewall-policy-create --firewall-rules "fw-rule-web fw-rule-int" fw-policy1
neutron firewall-create --name fw1 --router r0 fw-policy1