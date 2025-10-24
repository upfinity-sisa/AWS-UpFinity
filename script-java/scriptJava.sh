#!/bin/bash

sudo apt update && sudo apt upgrade -y

verificarJava() {
	#verfificando se o java está instalado na máquina
	java -version
	if [ $? = 0 ]; then
		echo "-----------------------------"
		echo "Java instalado"
		echo "-----------------------------"
		verificarMaven
	else
		instalarJava
	fi

}

verificarMaven(){
	mvn -version
	if [ $? = 0 ]; then
		echo "-----------------------------"
		echo "Maven instalado"
		echo "-----------------------------"
		instalarJar
	else
		instalarMaven
	fi
}

instalarMaven(){
	sudo apt install maven -y
	echo "-----------------------------"
	echo "Maven instalado com sucesso"
	echo "-----------------------------"
	instalarJar
}

instalarJava() {
	#instalando o java na máquina
	sudo apt install openjdk-17-jdk -y
	echo "-----------------------------"
	echo "Java instalado com sucesso"
	echo "-----------------------------"
	verificarMaven
}

instalarJar(){
	#instalando o arquivo .jar na máquina
	cd ~

	if [ -d "$HOME/sistema-java-upfinity" ]; then
		rm -rf "$HOME/sistema-java-upfinity"
	fi

	mkdir sistema-java-upfinity
	cd sistema-java-upfinity
	git clone https://github.com/upfinity-sisa/Java-UpFinity.git
	cd Java-UpFinity
	mvn clean package -DskipTests

	ARQ_JAR=$(find target -name "*.jar")

	if [ -z "$ARQ_JAR" ]; then
		echo "-----------------------------"
		echo "Erro ao encontrar o arquivo .jar"
		echo "-----------------------------"
		exit 1
	fi
	echo "-----------------------------"
	echo "Arquivo JAR encontrado: $ARQ_JAR"
	echo "-----------------------------"

	java -jar $ARQ_JAR "$@"
}


#rodando o java
verificarJava
