from django.core.cache import caches
from functools import wraps
import hashlib
import json

# Get the dedicated API cache
api_cache = caches["api_cache"]


def get_cache_key(prefix: str, *args, **kwargs) -> str:
    """Generate a consistent cache key."""
    key_data = json.dumps({"args": args, "kwargs": kwargs}, sort_keys=True)
    key_hash = hashlib.md5(key_data.encode()).hexdigest()[:12]
    return f"{prefix}:{key_hash}"


class APICache:
    """Flexible API caching utility."""
    
    def __init__(self, cache_name: str = "api_cache"):
        self.cache = caches[cache_name]
    
    def get(self, key: str):
        """Get value from cache."""
        return self.cache.get(key)
    
    def set(self, key: str, value, timeout: int = 300):
        """Set value in cache."""
        self.cache.set(key, value, timeout)
    
    def delete(self, key: str):
        """Delete key from cache."""
        self.cache.delete(key)
    
    def get_or_set(self, key: str, callback, timeout: int = 300):
        """Get from cache or set using callback."""
        value = self.cache.get(key)
        if value is None:
            value = callback()
            self.cache.set(key, value, timeout)
        return value
    
    def clear_prefix(self, prefix: str):
        """Clear all keys with prefix (requires redis client)."""
        from django_redis import get_redis_connection
        conn = get_redis_connection("api_cache")
        keys = conn.keys(f"*{prefix}*")
        if keys:
            conn.delete(*keys)


# Singleton instance
api_cache_client = APICache()


def cache_api_response(prefix: str, timeout: int = 300):
    """Decorator for caching API responses."""
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            cache_key = get_cache_key(prefix, *args, **kwargs)
            cached = api_cache.get(cache_key)
            
            if cached is not None:
                return cached
            
            result = func(*args, **kwargs)
            api_cache.set(cache_key, result, timeout)
            return result
        return wrapper
    return decorator