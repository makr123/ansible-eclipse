# Ansible managed: /workspace/users/albandri10/env/ansible/roles/eclipse/templates/Dockerfile.j2 modified on 2014-09-30 20:56:09 by albandri on albandri-laptop-misys
#FROM        debian:jessie
#FROM        stackbrew/ubuntu:14.04
FROM        jasongiedymin/ansible-base-ubuntu

# Volume can be accessed outside of container
VOLUME      [/workspace/eclipse]

MAINTAINER  Alban Andrieu "https://github.com/AlbanAndrieu"

ENV			DEBIAN_FRONTEND noninteractive
ENV         ECLIPSE_HOME /workspace/eclipse

# Working dir
WORKDIR /home/vagrant

# ADD
ADD defaults $WORKDIR/defaults
ADD meta $WORKDIR/meta
ADD files $WORKDIR/files
ADD handlers $WORKDIR/handlers
ADD tasks $WORKDIR/tasks
ADD templates $WORKDIR/templates
#ADD vars $WORKDIR/vars

# Here we continue to use add because
# there are a limited number of RUNs
# allowed.
ADD hosts /etc/ansible/hosts
ADD playbook.yml $WORKDIR/playbook.yml -vvvv

# Execute
RUN         ansible-playbook $WORKDIR/playbook.yml -i $WORKDIR/hosts -c local

EXPOSE      22
ENTRYPOINT  ["/workspace/eclipse/eclipse-4/eclipse"]
CMD ["-g", "deamon off;"]