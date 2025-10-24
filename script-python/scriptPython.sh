#!/bin/bash

sudo apt update && sudo apt upgrade -y

verificarPython() {
	python3 --version
	if [ $? = 0 ]; then
		echo "-----------------------------"
		echo "      Python instalado"
		echo "-----------------------------"
		baixarScript
	else
		instalarPython
	fi
}

instalarPython(){
	sudo apt install python3 python3-pip git -y
	echo "----------------------------------------"
	echo "      Python instalado com sucesso"
	echo "----------------------------------------"
	baixarScript
}

baixarScript(){

	if [ -d "Python-UpFinity" ]; then
		rm -rf Python-UpFinity
	fi

	cd
	git clone https://github.com/upfinity-sisa/Python-UpFinity.git
	rodarScript
}

rodarScript(){
	cd ~/Python-UpFinity
	pip3 install -r requirements.txt
	python3 captura.py
}

verificarPython

