
DOCKER_COMPOSE_FILE := ./srcs/docker-compose.yml
DATA_DIR := /home/manbengh/data
MARIADB_DATA_DIR := $(DATA_DIR)/mariadb
WORDPRESS_DATA_DIR := $(DATA_DIR)/wordpress

up:
	mkdir -p $(MARIADB_DATA_DIR)
	mkdir -p $(WORDPRESS_DATA_DIR)
	docker compose -f $(DOCKER_COMPOSE_FILE) up --build -d

down:
	docker compose -f $(DOCKER_COMPOSE_FILE) down

erase:
	make down
	docker volume rm srcs_mariadb_data srcs_wp_data || true
	sudo rm -rf $(DATA_DIR)
	make up

re:
	make down
	make up

.PHONY: up down erase re