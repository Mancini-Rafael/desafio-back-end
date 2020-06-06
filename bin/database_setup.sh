#!/bin/bash -e

echo "=== Sets up database for dev and test envs ==="

rails db:setup
rails db:test:prepare

echo "Database-setup Finished!"