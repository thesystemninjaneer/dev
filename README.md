# Overview
This is a generic repo of developer tools and containers to make developing easier.

# Development container

* Ansible
  * manage settings/configuration of local and remote machines
* AWS CLIv2
  * command line interface for amazon web service IaaS API's
* GCP SDK
  * command line interface for google compute engine IaaS API's/SDK's
* Terraform
  * IaC tool to configure/manage resources
* tmux
  * display terminals to many machine in a single window
* wget
  * command line tool for interacting with web endpoints
* kubectl
  * command line tool for manageing kubernetes services

# Docker Install
If you intend to run this container on your developer workstation/laptop but don't have docker installed, use the steps in this section to set it up.
## CentOS 8

1. Remove old docker installs
    ```
    $ sudo rpm -qa|grep docker
    docker-1.13.1-108.git4ef4b30.el7.centos.x86_64
    docker-client-1.13.1-108.git4ef4b30.el7.centos.x86_64
    docker-common-1.13.1-108.git4ef4b30.el7.centos.x86_64
    $ grep -i docker /etc/passwd
    dockerroot:x:998:996:Docker User:/var/lib/docker:/sbin/nologin
    $ grep -i docker /etc/group
    dockerroot:x:9999:juancarlos
    family:x:2222:root,juancarlos,dockerroot
    docker:x:1234:juancarlos
    # Example of using a separate volume for saving container images
    $ sudo ls -l /var/lib/ | grep docker
    lrwxrwxrwx. 1 root          root             6 Nov 15  2015 docker -> /data/
    s sudo yum remove docker \
                      docker-client \
                      docker-client-latest \
                      docker-common \
                      docker-latest \
                      docker-latest-logrotate \
                      docker-logrotate \
                      docker-engine
    ```
1. [Install the +1.17](https://docs.docker.com/install/linux/docker-ce/centos/) docker community centos packages
    ```
    sudo yum install -y yum-utils \
      device-mapper-persistent-data \
      lvm2 -y
    sudo yum-config-manager \
        --add-repo \
        https://download.docker.com/linux/centos/docker-ce.repo
    sudo yum install docker-ce docker-ce-cli containerd.io -y
    # Example of using a separate volume for saving container images
    sudo ln -s /data /var/lib/
    sudo systemctl enable docker
    # run docker at startup
    sudo systemctl start docker
    ```
