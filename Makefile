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
	ENVIRONMENT=$(ENV) docker-compose build --no-cache web

up:
	ENVIRONMENT=$(ENV) docker-compose --env-file .env.$(ENV) up -d
	@echo "✅ Environment $(ENV) is running at http://localhost:8000"

down:
	docker-compose down

restart: down up

# === Logs ===
logs:
	docker-compose logs -f web

logs-db:
	docker-compose logs -f db

logs-app:
	docker-compose logs -f web db

logs-all:
	docker-compose logs -f

logs-redis:
	docker-compose logs -f redis

up-live:
	ENVIRONMENT=$(ENV) docker-compose --env-file .env.$(ENV) up

# === Redis ===
redis-cli:
	docker-compose exec redis redis-cli

redis-monitor:
	docker-compose exec redis redis-cli monitor

redis-flush-api:
	docker-compose exec redis redis-cli -n 1 FLUSHDB

redis-keys:
	docker-compose exec redis redis-cli KEYS '*'

redis-info:
	docker-compose exec redis redis-cli INFO

# === Django ===
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

# === Deploy ===
deploy:
	docker-compose up -d --build web
	@echo "✅ Web app rebuilt and deployed"

rebuild-web:
	docker-compose build --no-cache web
	docker-compose up -d web
	@echo "✅ Web app fully rebuilt"

# === Cleanup ===
# Safe - removes only this project's containers and volumes
clean:
	docker-compose down -v
	@echo "✅ Project cleaned"

# Medium - also removes this project's images
clean-images:
	docker-compose down -v --rmi local
	@echo "✅ Project cleaned including local images"

# Nuclear - cleans everything in Docker (use carefully!)
clean-all:
	docker-compose down -v
	docker system prune -f
	@echo "⚠️  All Docker resources cleaned"

# Full nuclear - removes EVERYTHING including volumes
clean-nuclear:
	docker-compose down -v
	docker system prune -af --volumes
	@echo "☢️  Everything removed!"