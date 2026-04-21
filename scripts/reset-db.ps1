$ErrorActionPreference = "Stop"
$projectRoot = Split-Path -Parent $PSScriptRoot

Write-Host "Stopping containers and removing the database volume..."
docker compose --project-directory $projectRoot down -v

Write-Host ""
Write-Host "Starting PostgreSQL and pgAdmin with a fresh database..."
docker compose --project-directory $projectRoot up -d

Write-Host ""
Write-Host "Container status:"
docker compose --project-directory $projectRoot ps

Write-Host ""
Write-Host "Database reset complete."
Write-Host "PostgreSQL will rerun init-db/01-load-data.sql on this fresh volume."
