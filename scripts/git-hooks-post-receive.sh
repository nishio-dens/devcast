#!/bin/bash

echo "--- DevCast Article Deploy ---"
echo ""

echo "1/3 Fetch Devcast Repo"
cd /git/workdir/devcast
git fetch origin
git reset --hard origin/master
git checkout origin/master
echo "2/3 Import Repo"
cd /app/current; RAILS_ENV=production SECRET_KEY_BASE=a REPO_DIR="/git/workdir/devcast" REPO_NAME="devcast"  bundle exec rake repo:import
echo "3/3 Import Complete"
