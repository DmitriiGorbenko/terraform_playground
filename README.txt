terraform plan   
terraform apply -auto-approve
ansible-playbook -i inventory.ini update_host.yml  
ansible-playbook -i inventory.ini generate_on_master1_and_deploy.yml

запуск kubespray
ansible-playbook -u root --ask-pass -i inventory/sample/inventory.ini cluster.yml -b --diff