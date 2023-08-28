ENV?=
FLAGS_ENV= ${if ${ENV},-l ${ENV}}

TAGS?=
FLAGS_TAGS= ${if ${TAGS},--tags ${TAGS}}

RUN_PLAYBOOK=ansible-playbook --ask-become-pass --private-key=~/.ssh/id_rs -i inventory ${FLAGS_ENV} ${FLAGS_TAGS}

all:
	${RUN_PLAYBOOK} setup.yml

ssh:
	 ${RUN_PLAYBOOK} ssh_config.yml
