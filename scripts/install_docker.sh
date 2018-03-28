#!/usr/bin/env bash

# Install docker-compose's latest version
install_docker_compose() {
    COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep 'tag_name' | cut -d\" -f4);

    curl -L https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose;

    if [[ $? != 0 ]]; then
        printf "Docker Compose could not be installed, try to install manually!";

        exit 1;
    fi

    chmod +x /usr/local/bin/docker-compose;

    printf "Docker Compose was sucessfully installed!\n"

    docker-compose -v
}

# Install docker's latest version
install_docker() {
    apt-get update;

    apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common;

    # Set Docker GPG Key
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -;
    apt-key fingerprint 0EBFCD88;

    # Add stable docker repository
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable";

    apt-get update;

    apt-get install -y docker-ce;

    if [[ $? != 0 ]]; then
        printf "It was not possible to install docker, try running the command manually.\n";
        exit 1;
    else
        printf "Docker was succesfully installed! \nNext Step: Install Docker Compose.\n";
        sleep 1.0

        # Call non root docker management function
        non_root_docker_management;

        # Call docker-compose installation function
        install_docker_compose;
    fi
}

non_root_docker_management() {
    USER=$1;

    #Check if docker group exists
    grep -q docker /etc/group;

    if [[ $? != 0 ]]; then
        printf "Docker group does not exist, adding it...\n";

        groupadd docker;
    fi

    printf "Checking if user is a member of Docker group...\n";

    id -Gn $USER | grep -q docker;

    if [[ $? != 0 ]]; then
        printf "User is not a member of Docker group, adding him now...\n"

        usermod -aG docker $USER;
    else
        printf "User is already a member of Docker group.\n"
    fi
}

check_docker_installation() {
  printf "Checking if you already docker installed.";
    sleep 0.5;
    printf ".";
    sleep 0.5;
    printf ".\n\n";

    which docker;

    if [[ $? != 0 ]]; then
        # Call Docker installation method.
        printf "Docker is not installed yet!\n";
        sleep 3.0;
        install_docker;
    else
        printf "Docker is already installed, perfoming upgrade of Docker version...\n";
        apt-get upgrade -y docker;
    fi
}

ROOT=$(whoami);

if [ "$#" -ne 1 ]; then
    printf "You must provide your user.\n\nUsage: sudo ./install_docker.sh {USER}\n";

    exit 1;
elif [ $ROOT != "root" ]; then
    printf "You must be root to run this script.\n\nUsage: sudo ./install_docker.sh {USER}\n"

    exit 1;
fi

check_docker_installation;