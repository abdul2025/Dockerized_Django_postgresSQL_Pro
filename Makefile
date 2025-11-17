.PHONY: help build up down restart logs shell migrate makemigrations test clean

ENV ?= dev

help:
	@echo "Django Docker Commands"
	@echo "====================="
	@echo "Usage: make [command] ENV=[dev|uat|prod]"
	@echo ""
	@echo "Commands:"
	@echo "  build           - Build Docker images"
	@echo "  up              - Start containers"
	@echo "  down            - Stop containers"
	@echo "  restart         - Restart containers"
	@echo "  logs            - View logs"
	@echo "  shell           - Open Django shell"
	@echo "  bash            - Open bash shell"
	@echo "  migrate         - Run migrations"
	@echo "  makemigrations  - Create migrations"
	@echo "  createsuperuser - Create superuser"
	@echo "  collectstatic   - Collect static files"
	@echo "  clean           - Remove containers and volumes"

build:
	ENVIRONMENT=$(ENV) docker-compose build

up:
	ENVIRONMENT=$(ENV) docker-compose --env-file .env.$(ENV) up -d
	@echo "✅ Environment $(ENV) is running at http://localhost:8000"

down:
	docker-compose down

restart: down up

logs:
	docker-compose logs -f

shell:
	docker-compose exec web python manage.py shell

bash:
	docker-compose exec web bash

migrate:
	docker-compose exec web python manage.py migrate

makemigrations:
	docker-compose exec web python manage.py makemigrations

createsuperuser:
	docker-compose exec web python manage.py createsuperuser

collectstatic:
	docker-compose exec web python manage.py collectstatic --noinput

clean:
	docker-compose down -v
	docker system prune -f
