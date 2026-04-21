# Start and manage PostgreSQL Docker containers

$ErrorActionPreference = "Stop"
$projectRoot = Split-Path -Parent $PSScriptRoot

## Start all containers
echo "Starting PostgreSQL and pgAdmin containers..."
docker compose --project-directory $projectRoot up -d

## Wait for services to be ready
echo "Waiting for services to initialize..."
Start-Sleep -Seconds 5

## Display status
echo ""
echo "=== Container Status ==="
docker compose --project-directory $projectRoot ps

echo ""
echo "=== PostgreSQL Connection Details ==="
echo "Host: localhost"
echo "Port: 5432"
echo "Username: postgres"
echo "Password: postgres"
echo "Database: mydb"

echo ""
echo "=== pgAdmin Access ==="
echo "URL: http://localhost:5050"
echo "Email: admin@email.com"
echo "Password: admin"

echo ""
echo "Services are running! Use 'docker compose logs -f' to view logs."
