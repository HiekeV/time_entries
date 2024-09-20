#!/bin/sh

# Wait for the application to be ready
while [ ! -f /tmp/app_ready ]; do sleep 1; done

# Run Laravel migration
php artisan migrate --force