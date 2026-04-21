$ErrorActionPreference = "Stop"
$projectRoot = Split-Path -Parent $PSScriptRoot

Write-Host "Reloading periode and superstore from CSV files..."
docker compose --project-directory $projectRoot exec postgres sh -lc 'psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f /data/scripts/sql/reload-data.sql'

Write-Host ""
Write-Host "Row counts after reload:"
docker compose --project-directory $projectRoot exec postgres sh -lc 'psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c "SELECT '\''periode'\'' AS table_name, COUNT(*) AS total_rows FROM periode UNION ALL SELECT '\''superstore'\'' AS table_name, COUNT(*) AS total_rows FROM superstore;"'
