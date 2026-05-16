#!/bin/bash

dnf install -y ansible-core wget git-core rsync vim awscli2
aws s3 cp s3://${BUCKET}/${FILE} ${USER_HOME}/${FILE}
chown ec2-user. ${USER_HOME}/${FILE}
echo "127.0.0.1   aap.example.org" >> /etc/hosts

# su - ec2-user -c "
# tar zxvf ${USER_HOME}/${FILE} -C ${USER_HOME} && 
# cd ${USER_HOME}/ansible-automation-platform-containerized-setup-* &&
# cat <<EOF > inventory
#     [automationgateway]
#     aap.example.org

#     [automationcontroller]
#     aap.example.org

#     [automationhub]
#     aap.example.org

#     [automationeda]
#     aap.example.org

#     [database]
#     aap.example.org

#     [all:vars]
#     ansible_connection=local

#     postgresql_admin_username=postgres
#     postgresql_admin_password=P@ssw0rd

#     registry_username=${RH_USERNAME}
#     registry_password=${RH_PASSWORD}

#     redis_mode=standalone

#     gateway_admin_password=P@ssw0rd
#     gateway_pg_host=aap.example.org
#     gateway_pg_password=P@ssw0rd

#     controller_admin_password=P@ssw0rd
#     controller_pg_host=aap.example.org
#     controller_pg_password=P@ssw0rd
#     controller_percent_memory_capacity=0.5

#     hub_admin_password=P@ssw0rd
#     hub_pg_host=aap.example.org
#     hub_pg_password=P@ssw0rd
#     hub_seed_collections=false

#     eda_admin_password=P@ssw0rd
#     eda_pg_host=aap.example.org
#     eda_pg_password=P@ssw0rd
# EOF &&
# ansible-playbook -i inventory ansible.containerized_installer.install"