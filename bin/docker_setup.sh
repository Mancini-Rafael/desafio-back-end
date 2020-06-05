#!/bin/bash -e

echo "=== Starting project setup for docker development environment ==="
if ! command -v 'docker-compose' > /dev/null; then
  echo "Docker Compose not installed. Install before continue."
  exit 1
fi

echo "=== Docker Compose installed. Proceeding... ==="
echo "=== Building containers ==="
docker-compose build app

echo "=== Setting up on mode DEVELOPMENT ==="
cp -f .env.development .env
docker-compose run --rm --service-ports app ./bin/database_setup.sh
echo "Setup Finished! Run \"docker-compose up\" up to start running"