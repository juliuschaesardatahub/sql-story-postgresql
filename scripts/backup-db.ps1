$ErrorActionPreference = "Stop"

$projectRoot = Split-Path -Parent $PSScriptRoot
$backupDir = Join-Path $projectRoot "backups"
$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$backupFileName = "postgres-$timestamp.backup"
$containerBackupPath = "/backups/$backupFileName"
$hostBackupPath = Join-Path $backupDir $backupFileName

if (-not (Test-Path $backupDir)) {
    New-Item -ItemType Directory -Path $backupDir | Out-Null
}

Write-Host "Starting PostgreSQL container if needed..."
docker compose --project-directory $projectRoot up -d postgres

Write-Host "Creating database backup..."
docker compose --project-directory $projectRoot exec -T postgres sh -lc "pg_dump -U `"`$POSTGRES_USER`" -d `"`$POSTGRES_DB`" --format=custom --clean --if-exists --file=$containerBackupPath"

Write-Host ""
Write-Host "Backup created:"
Write-Host $hostBackupPath
