#!/bin/bash -e

echo "=== Sets up database for dev and test envs ==="

rails db:drop
rails db:create
rails db:schema:load
rails db:migrate
rails db:seed
rails db:test:prepare

echo "Database-setup Finished!"