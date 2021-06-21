#!/usr/bin/env bash

# Create quickstart Strapi project.
yarn create strapi-app tmp-app --quickstart --no-run
mv tmp-app/* . && rm -rf tmp-app

# Install additional dependencies.
yarn add pg
yarn add platformsh-config
yarn add strapi-plugin-graphql

# Move the Platform.sh-specific configuration.
rm config/environments/development/database.json && mv platformsh/database.js config/environments/development/database.js
rm config/environments/development/server.json && mv platformsh/server.json config/environments/development/server.json

# Rebuild the admin panel.
yarn strapi install graphql
yarn build

# Move index.html with working admin link.
mv platformsh/index.html public/index.html

# Make start command executable.
chmod +x start.sh
