COMPOSE = docker compose -f srcs/docker-compose.yml

all: up

up:
	$(COMPOSE) up --build

build:
	$(COMPOSE) build 

down:
	$(COMPOSE) down

clean:
	$(COMPOSE) down -v --remove-orphans --rmi all

fclean: clean
	sudo rm -fr ~/data/wordpress/* ~/data/mariadb/*
	docker system prune -af 

re: fclean all

.PHONY: all up down clean re 