from .base import *

DEBUG = True

# Development-specific apps
INSTALLED_APPS += [
    'debug_toolbar',
    'django_extensions',
]

MIDDLEWARE += [
    'debug_toolbar.middleware.DebugToolbarMiddleware',
]

# Debug toolbar
INTERNAL_IPS = [
    '127.0.0.1',
    'localhost',
]

# Django REST Framework - Add browsable API in dev
REST_FRAMEWORK['DEFAULT_RENDERER_CLASSES'] = [
    'rest_framework.renderers.JSONRenderer',
    'rest_framework.renderers.BrowsableAPIRenderer',
]

# CORS - Allow all in development
CORS_ALLOW_ALL_ORIGINS = True
