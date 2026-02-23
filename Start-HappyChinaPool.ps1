# HappyChina Mining Pool - Windows PowerShell Launcher
# Right-click this file and select "Run with PowerShell"

Write-Host "============================================" -ForegroundColor Green
Write-Host "  HappyChina Mining Pool - Windows Launcher" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green
Write-Host ""

# Check for Docker
$docker = Get-Command docker -ErrorAction SilentlyContinue
if (-not $docker) {
    Write-Host "[ERROR] Docker Desktop is not installed!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please install Docker Desktop for Windows:" -ForegroundColor Yellow
    Write-Host "  https://www.docker.com/products/docker-desktop/" -ForegroundColor Cyan
    Write-Host ""
    Start-Process "https://www.docker.com/products/docker-desktop/"
    Read-Host "Press Enter to exit"
    exit 1
}

# Check if Docker is running
$dockerInfo = docker info 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "[INFO] Docker Desktop is not running. Starting it..." -ForegroundColor Yellow
    Start-Process "C:\Program Files\Docker\Docker\Docker Desktop.exe"
    Write-Host "Waiting for Docker to start..."
    do {
        Start-Sleep -Seconds 3
        $dockerInfo = docker info 2>&1
    } while ($LASTEXITCODE -ne 0)
    Write-Host "Docker is ready!" -ForegroundColor Green
}

Write-Host "[OK] Docker is running" -ForegroundColor Green
Write-Host ""

# Create data directories
Write-Host "Creating data directories..."
$coins = @("bitcoin","litecoin","dogecoin","namecoin","pepecoin","bells","luckycoin","junkcoin","dingocoin","shibacoin","trumpow","pool")
foreach ($coin in $coins) {
    $dir = Join-Path $PSScriptRoot "data\$coin"
    if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
}

# Start the pool
Write-Host ""
Write-Host "Starting HappyChina Pool..." -ForegroundColor Cyan
Write-Host "This may take a few minutes on first run (downloading images)..."
Write-Host ""

Set-Location $PSScriptRoot
docker compose up -d

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "[ERROR] Failed to start. Make sure Docker Desktop is running." -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host ""
Write-Host "============================================" -ForegroundColor Green
Write-Host "  HappyChina Pool is running!" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green
Write-Host ""
Write-Host "  Web Dashboard: " -NoNewline; Write-Host "http://localhost:8080" -ForegroundColor Cyan
Write-Host "  SHA-256 Stratum: stratum+tcp://localhost:3342"
Write-Host "  Scrypt Stratum:  stratum+tcp://localhost:3333"
Write-Host ""
Write-Host "  First Steps:"
Write-Host "  1. Open http://localhost:8080 in your browser"
Write-Host "  2. Register an account (first user becomes admin)"
Write-Host "  3. Set your wallet addresses in profile settings"
Write-Host "  4. Connect your miners!"
Write-Host ""

# Open browser
Start-Process "http://localhost:8080"

Write-Host "Press Enter to view logs (Ctrl+C to exit)..."
Read-Host
docker compose logs -f backend
