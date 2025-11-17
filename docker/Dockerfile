FROM python:3.11-slim

ARG ENVIRONMENT=dev

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    postgresql-client \
    gcc \
    python3-dev \
    musl-dev \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements
COPY requirements/base.txt requirements/base.txt
COPY requirements/${ENVIRONMENT}.txt requirements/${ENVIRONMENT}.txt

# Install Python dependencies
RUN pip install --upgrade pip && \
    pip install -r requirements/${ENVIRONMENT}.txt

# Copy project
COPY . .

# Create necessary directories
RUN mkdir -p staticfiles mediafiles logs

# Create non-root user
RUN useradd -m -u 1000 appuser && \
    chown -R appuser:appuser /app

USER appuser

EXPOSE 8000
