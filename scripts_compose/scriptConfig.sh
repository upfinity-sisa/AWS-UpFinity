#/bin/bash

echo "-------------------------------------------------------------------------"
echo "                  INICIANDO CONFIGURAÇÃO DA INSTÂNCIA"
echo "-------------------------------------------------------------------------"

sudo apt update && sudo apt upgrade -y

baixar_docker() {

        echo "Baixando docker"
        sudo apt install docker.io

}

baixar_compose() {

        echo "Baixando docker compose"
        sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        sudo chmod +x /usr/local/bin/docker-compose

}

docker --version

if [ $? = 0 ]
        then echo "Docker instalado"
        else baixar_docker
fi

docker-compose --version

if [ $? = 0 ]
        then echo "Docker compose instalado"
        else baixar_compose

fi

echo "Informe seu nome de usuário do DockerHub"
read nome
echo "Informe sua senha do DockerHub (Usuário: $nome)"
read senha

echo "$senha" | docker login -u "$nome" --password-stdin

echo "------------------------------------------------------------------------"
echo "                         Configuração finalizada"
echo "------------------------------------------------------------------------"
