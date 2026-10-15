#!/usr/bin/env bash
# Builds the installable WordPress theme: dist/naja-restaurant-theme.zip
# The theme's PHP lives in wordpress-theme/naja-restaurant/; the front end
# (css/, js/, assets/) is shared with the static site and copied in here.
set -euo pipefail
cd "$(dirname "$0")/.."

out=dist/naja-restaurant
rm -rf "$out" dist/naja-restaurant-theme.zip
mkdir -p "$out"
cp -R wordpress-theme/naja-restaurant/. "$out/"
cp -R css js assets "$out/"
(cd dist && zip -qr naja-restaurant-theme.zip naja-restaurant)
echo "Built dist/naja-restaurant-theme.zip"
