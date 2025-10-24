#!/bin/bash

echo "--------------------------------------------------------------"
echo "             INICIANDO CONFIGURAÇÃO DA INSTÂNCIA"
echo "--------------------------------------------------------------"

sudo apt update && sudo apt upgrade -y
sudo apt install -y git

read -sp "Digite a NOVA senha para o usuário UBUNTU: " senha_ubuntu
echo

echo "ubuntu:$senha_ubuntu" | sudo chpasswd

read -sp "Digite a NOVA senha para o usuário ROOT: " senha_root
echo

echo "root:$senha_root" | sudo chpasswd

if ! getent group upfinity > /dev/null; then
	sudo groupadd upfinity
fi

if ! id "breno-upfinity" &> /dev/null; then
	sudo useradd -m -s /bin/bash -G "sudo,upfinity" "breno-upfinity"
	echo "breno-upfinity:1234" | sudo chpasswd
fi

sudo su - breno-upfinity -c " \
	if [ -d 'AWS-UpFinity' ]; then \
		rm -rf AWS-UpFinity; \
	fi; \
	git clone https://github.com/upfinity-sisa/AWS-UpFinity.git; \
	chmod +x ~/AWS-UpFinity/scriptRun.sh; \
	chmod +x ~/AWS-UpFinity/script-java/scriptJava.sh; \
	chmod +x ~/AWS-UpFinity/script-python/scriptPython.sh; \
"

echo "--------------------------------------------------------------"
echo "             CONFIGURAÇÃO DA INSTÂNCIA CONCLUÍDA"
echo "--------------------------------------------------------------"
