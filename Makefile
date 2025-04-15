COMPOSE = docker compose -f srcs/docker-compose.yml
VOLUME_MARIADB_PATH = $(HOME)/data/mariadb
VOLUME_WORDPRESS_PATH = $(HOME)/data/wordpress

define create_dir_not_exists
	@if [ ! -d $(1) ]; then \
		mkdir -p $(1) && echo "$(1): Created"; \
	else \
		echo "$(1): Already Exists"; \
	fi
endef

all: up

up: build
	$(COMPOSE) up
build:
	$(call create_dir_not_exists, $(VOLUME_WORDPRESS_PATH))
	$(call create_dir_not_exists, $(VOLUME_MARIADB_PATH))
	$(COMPOSE) build 

down:
	$(COMPOSE) down

clean:
	$(COMPOSE) down -v --remove-orphans --rmi all

fclean: clean
	rm -fr ~/data/wordpress/* ~/data/mariadb/*
	docker system prune -af 


re: fclean all

.PHONY: all up down clean fclean re 