#!/bin/sh
sh /app/docker/startup.sh &
sh /app/db-migration.sh

# Keep the container running
tail -f /dev/null