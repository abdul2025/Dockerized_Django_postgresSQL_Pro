# Django REST Framework + PostgreSQL Starter

A production-ready Django REST Framework template with PostgreSQL, Docker, and multi-environment configuration support.

## ✨ Features

- 🚀 Django REST Framework pre-configured
- 🐘 PostgreSQL database integration
- 🐳 Docker & Docker Compose setup
- 🔧 Multi-environment configuration (Dev/UAT/Prod)
- 📦 Organized requirements structure
- ⚡ Makefile for common tasks
- 🔐 Environment-based secret management

## 📋 Prerequisites

- Docker Engine 20.10+
- Docker Compose 2.0+
- Make (optional but recommended)

## 🚀 Quick Start

### Initial Setup
```bash
# Clone the repository
git clone <repository-url>
cd starterPro

# Copy environment files
cp .env.dev.example .env.dev  # If examples exist

# Build Docker containers
make build

# Start the development server
make up

# Run database migrations
make migrate

# Create a superuser account
make createsuperuser
```

Visit **http://localhost:8000** to see your application running.

## 🌍 Environment Management

This project supports three environments with isolated configurations:

| Environment | Command | Use Case |
|------------|---------|----------|
| **Development** | `make up ENV=dev` | Local development with hot-reload |
| **UAT** | `make up ENV=uat` | User acceptance testing |
| **Production** | `make up ENV=prod` | Production deployment |

### Environment-Specific Settings

Each environment has its own:
- Settings file (`config/settings/{env}.py`)
- Requirements file (`requirements/{env}.txt`)
- Environment variables (`.env.{env}`)

## 📚 Available Commands

### Development
```bash
make up                # Start containers (default: dev)
make down              # Stop containers
make restart           # Restart containers
make logs              # View container logs
make logs-f            # Follow container logs
```

### Django Management
```bash
make shell             # Open Django shell
make bash              # Open container bash shell
make migrate           # Apply database migrations
make makemigrations    # Create new migrations
make createsuperuser   # Create admin user
make collectstatic     # Collect static files
```

### Database
```bash
make dbshell           # PostgreSQL shell
make dumpdata          # Export database data
make loaddata          # Import database data
```

### Maintenance
```bash
make clean             # Remove containers and volumes
make rebuild           # Clean build from scratch
make test              # Run test suite
```

## 📁 Project Structure
```
starterPro/
├── apps/                      # Django applications
│   └── core/                  # Example app
│       ├── migrations/
│       ├── models.py
│       ├── serializers.py
│       ├── views.py
│       └── urls.py
├── config/                    # Project configuration
│   ├── settings/
│   │   ├── base.py           # Shared settings
│   │   ├── dev.py            # Development overrides
│   │   ├── uat.py            # UAT overrides
│   │   └── prod.py           # Production overrides
│   ├── urls.py               # URL routing
│   └── wsgi.py               # WSGI configuration
├── docker/
│   ├── Dockerfile            # Application container
│   └── docker-compose.yml    # Service orchestration
├── requirements/
│   ├── base.txt              # Core dependencies
│   ├── dev.txt               # Development tools
│   ├── uat.txt               # UAT-specific packages
│   └── prod.txt              # Production packages
├── static/                    # Static files (CSS, JS, images)
├── media/                     # User-uploaded files
├── .env.dev                   # Development environment variables
├── .env.uat                   # UAT environment variables
├── .env.prod                  # Production environment variables
├── .gitignore
├── Makefile                   # Command shortcuts
├── manage.py
└── README.md
```

## ⚙️ Configuration

### Environment Variables

Key environment variables in `.env.*` files:
```bash
# Django
DJANGO_SECRET_KEY=your-secret-key-here
DJANGO_DEBUG=True
DJANGO_ALLOWED_HOSTS=localhost,127.0.0.1

# Database
DB_NAME=starterdb
DB_USER=postgres
DB_PASSWORD=postgres
DB_HOST=db
DB_PORT=5432

# Optional: Additional services
REDIS_URL=redis://redis:6379/0
CELERY_BROKER_URL=redis://redis:6379/0
```

## 🚢 Deployment

### Pre-Production Checklist

Before deploying to production, ensure you:

- [ ] Generate a strong `DJANGO_SECRET_KEY` (use `make generate-secret`)
- [ ] Update all database passwords to secure values
- [ ] Configure `ALLOWED_HOSTS` with your domain(s)
- [ ] Set `DEBUG=False` in production
- [ ] Configure HTTPS/SSL certificates
- [ ] Set up static file serving (CDN/S3)
- [ ] Configure email backend
- [ ] Enable logging and monitoring
- [ ] Test thoroughly in UAT environment
- [ ] Set up automated backups
- [ ] Review security settings checklist

### Production Deployment
```bash
# Build production image
make build ENV=prod

# Start production services
make up ENV=prod

# Collect static files
make collectstatic ENV=prod

# Run migrations
make migrate ENV=prod
```

## 🧪 Testing
```bash
# Run all tests
make test

# Run specific test
python manage.py test apps.core.tests.TestClassName

# Run with coverage
make test-coverage
```

## 🔧 Troubleshooting

### Common Issues

**Port already in use**
```bash
# Check what's using port 8000
lsof -i :8000
# Stop containers and try again
make down && make up
```

**Database connection errors**
```bash
# Restart database container
docker-compose restart db
# Check database logs
docker-compose logs db
```

**Permission errors**
```bash
# Fix file permissions
sudo chown -R $USER:$USER .
```



** Monitoring Portainer Tool **
Go to https://localhost:9443

** Redis ** 
Go to http://localhost:5540

## 📖 Additional Resources

- [Django Documentation](https://docs.djangoproject.com/)
- [Django REST Framework](https://www.django-rest-framework.org/)
- [Docker Documentation](https://docs.docker.com/)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Django Software Foundation
- Docker Community
- PostgreSQL Development Group

---

**Need help?** Open an issue or reach out to the maintainers.