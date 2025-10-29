#!/bin/bash

sudo apt update && sudo apt upgrade -y

sudo apt install python3.12-venv -y
echo "-------------------------------------------"
echo "         Venv instalado com sucesso"
echo "-------------------------------------------"


verificarPython() {
	python3 --version
	if [ $? = 0 ]; then
		echo "-----------------------------"
		echo "      Python instalado"
		echo "-----------------------------"
		verificarPip
	else
		instalarPython
	fi
}

verificarPip() {
	pip3 --version
	if [ $? = 0  ]; then
		echo "---------------------------------"
		echo "         Pip3 instalado"
		echo "---------------------------------"
		baixarScript
	else
		instalarPip
	fi
}

instalarPython(){
	sudo apt install python3 -y
	echo "----------------------------------------"
	echo "      Python instalado com sucesso"
	echo "----------------------------------------"
	verificarPip
}

instalarPip() {
	sudo apt install python3-pip -y
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
	cd ~/Python-UpFinity/script-captura
	python3 -m venv venv
	source venv/bin/activate
	pip3 install -r requirements.txt
	if [ -f ".env" ]; then
		echo "O arquivo .env já existe..."
		python3 main.py
	else
		cat > ".env" << EOF
USER_DB=funcUpFinity
PASSWORD_DB=UpFinity123
HOST_DB=3.212.222.224
PORT_DB=3306
DATABASE_DB=upfinity
EOF
		python3 main.py
	fi
	deactivate
}

verificarPython
