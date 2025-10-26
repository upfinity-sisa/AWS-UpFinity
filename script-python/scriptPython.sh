#!/bin/bash

sudo apt update && sudo apt upgrade -y

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
		verificarVenv
	else
		instalarPip
	fi
}

verificarVenv(){
	if python3 -c "import venv" &> /dev/null; then
		echo "---------------------------------"
		echo "         Venv instalado"
		echo "---------------------------------"
		baixarScript
	else
		instalarVenv
	fi
}

instalarVenv() {
	sudo apt install python3.12-venv -y
	echo "-------------------------------------------"
	echo "         Venv instalado com sucesso"
	echo "-------------------------------------------"
	baixarScript

}

instalarPython(){
	sudo apt install python3 -y
	echo "----------------------------------------"
	echo "      Python instalado com sucesso"
	echo "----------------------------------------"
	verificarPip
}

instalarPip() {
	sudo apt install python3-pip python3.12-venv -y
	echo "---------------------------------------"
	echo "      Pip3 instalado com sucesso"
	echo "---------------------------------------"
	verificarVenv
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
	source venv/bin/activate
	pip3 install -r requirements.txt
	python3 captura.py
	deactivate
}

verificarPython

