#!/bin/bash

salvar_env_dev() {

cat <<EOF > .env.dev

AMBIENTE_PROCESSO=desenvolvimento

# Configurações de conexão com o banco de dados
DB_HOST=upfinity-db
DB_DATABASE='upfinity'
DB_USER='root'
DB_PASSWORD='urubu100'
DB_PORT=3306

# Configurações do servidor de aplicação
APP_PORT=3333
APP_HOST=localhost

EOF

}

salvar_arquivo() {

cat <<EOF > docker-compose.yaml

services:
  db:
    image: catarinagimenes/meu_bd:latest
    container_name: upfinity-db
    restart: always
    env_file:
      - .env.dev
    ports:
      - "3307:3306"
    volumes:
      - db_data:/var/lib/mysql
    environment:
      MYSQL_ROOT_PASSWORD: urubu100
      MYSQL_DATABASE: upfinity
    networks:
      - private_network

  app:
    image: catarinagimenes/meu_site:latest
    container_name: upfinity-site
    restart: always
    depends_on:
      - db
    env_file:
      - .env.dev
    ports:
      - "3333:3333"
    networks:
      - public_network
      - private_network

volumes:
  db_data:

networks:
  private_network:
    driver: bridge
  public_network:
    driver: bridge

EOF

}

if [ -f "docker-compose.yaml" ]; then
        echo "Arquivo existe"
else
        touch docker-compose.yaml
        echo "Criando docker-compose.yaml"
fi

if [ -f ".env.dev" ]
        then echo ".env.dev já existe"
        else
                echo "criando .env.dev"
                touch .env.dev
fi

salvar_arquivo
salvar_env_dev
echo "Docker Compose salvo"
