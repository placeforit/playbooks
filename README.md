# playbooks
For setting up my development environment in ansible

## Instructions

You will need to run the bootstrap script:

This script downloads the playbooks in this repo and installs some dependancies

```bash
 curl https://raw.githubusercontent.com/placeforit/playbooks/main/scripts/bootstrap.sh | bash
```

## 
## inventory example for use with hosts playbook

[k8s_controlplane]
controlplane1 ansible_host=192.168.x.x ansible_ssh_host=controlplane1 ansible_ssh_user=eatpie ansible_ssh_private_key_file=~/.ssh/id_rsa2
