#!/bin/sh
set -eu

cd /data

echo "Downloading Sri Lanka OpenStreetMap data..."

wget -O sri-lanka.osm.pbf \
  https://download.geofabrik.de/asia/sri-lanka-latest.osm.pbf

echo "Preparing OSRM routing graph..."

osrm-extract -p /opt/car.lua /data/sri-lanka.osm.pbf
osrm-partition /data/sri-lanka.osrm
osrm-customize /data/sri-lanka.osrm

echo "Starting OSRM..."

exec osrm-routed \
  --algorithm mld \
  --ip 0.0.0.0 \
  --port "${PORT:-10000}" \
  /data/sri-lanka.osrm
