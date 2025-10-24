#!/bin/bash

sudo apt update && sudo apt upgrade -y

verificarPython() {
	python3 --version
	if [ $? = 0 ]; then
		echo "-----------------------------"
		echo "      Python instalado"
		echo "-----------------------------"

		pip3 --version
		if [ $? = 0  ]; then
			echo "---------------------------------"
			echo "         Pip3 instalado"
			echo "---------------------------------"
			baixarScript
		else
			instalarPip
		fi
	else
		instalarPython
	fi
}

instalarPython(){
	sudo apt install python3 -y
	echo "----------------------------------------"
	echo "      Python instalado com sucesso"
	echo "----------------------------------------"
	baixarScript
}

instalarPip() {
	sudo apt install python3-pip python3.12-venv -y
	echo "---------------------------------------"
	echo "      Pip3 instalado com sucesso"
	echo "---------------------------------------"
	baixarScript
}

baixarScript(){
	cd ~
	if [ -d "$HOME/Python-UpFinity" ]; then
		rm -rf "$HOME/Python-UpFinity"
	fi

	git clone https://github.com/upfinity-sisa/Python-UpFinity.git
	rodarScript
}

rodarScript(){
	cd ~/Python-UpFinity
	python3 -m venv venv
	source /venv/bin/activate
	pip3 install -r requirements.txt
	python3 captura.py
	deactivate
}

verificarPython

