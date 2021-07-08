_LAV			=	\033[36m
_BOL			=	\033[1m
_RES			=	\033[0m


SRCS			=	srcs/
REQU			=	srcs/requirements
YAML			=	srcs/docker-compose.yml
SETU			=	srcs/requirements/tools/setup.sh

all: up

up:
	@ docker-compose -f $(YAML) up -d --build
	@ sleep 5
	@ echo "$(_LAV)$(_BOL)[COMPLETE!] Containers are now built and running.$(_RES)"

stop:
	@ docker-compose -f $(YAML) stop
	@ echo "$(_LAV)$(_BOL)Containers are now stop.$(_RES)"

down:
	@ docker-compose -f $(YAML) down
	@ echo "$(_LAV)$(_BOL)Containers are now downed. (stop + delete)$(_RES)"

ps:
	@ docker-compose -f $(YAML) ps

re:	stop up

# clean: down
# 	@docker system prune
# 	@docker volume rm srcs_db_vol
# 	@docker volume rm srcs_wp_vol

.PHONY:	all setup up stop down ps re
