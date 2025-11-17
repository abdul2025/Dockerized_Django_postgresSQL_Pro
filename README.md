# Django REST Framework + PostgreSQL

Simple Django REST Framework setup with PostgreSQL and Docker.

## Quick Start

```bash
# Build containers
make build

# Start development
make up

# Run migrations
make migrate

# Create superuser
make createsuperuser

# Visit http://localhost:8000
```

## Environment Switching

```bash
# Development
make up ENV=dev

# UAT
make up ENV=uat

# Production
make up ENV=prod
```

## Commands

```bash
make logs              # View logs
make shell             # Django shell
make bash              # Bash shell
make migrate           # Run migrations
make makemigrations    # Create migrations
make collectstatic     # Collect static files
make down              # Stop containers
make clean             # Remove everything
```

## Project Structure

```
starterPro/
├── config/            # Django configuration
│   ├── settings/
│   │   ├── base.py
│   │   ├── dev.py
│   │   ├── uat.py
│   │   └── prod.py
│   ├── urls.py
│   └── wsgi.py
├── docker/
│   └── Dockerfile
├── requirements/
│   ├── base.txt
│   ├── dev.txt
│   ├── uat.txt
│   └── prod.txt
├── apps/              # Your Django apps
├── .env.dev
├── .env.uat
├── .env.prod
├── docker-compose.yml
└── Makefile
```

## Before Production

- [ ] Update `DJANGO_SECRET_KEY` in `.env.prod`
- [ ] Change database passwords
- [ ] Update `ALLOWED_HOSTS`
- [ ] Test in UAT first

## License

MIT
