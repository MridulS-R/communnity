#!/usr/bin/env bash
set -o errexit

bundle install
bundle exec rails tailwindcss:build || echo "Tailwind build failed; continuing"
bundle exec rails assets:precompile || echo "Skipping assets precompile"
