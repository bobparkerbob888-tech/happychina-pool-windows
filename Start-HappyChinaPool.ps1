# HappyChina Mining Pool - Windows PowerShell Launcher (Smart Auto-Tuning)
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

# Detect system resources
$totalRAM_MB = [math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1MB)
$cpuCores = (Get-CimInstance Win32_Processor).NumberOfLogicalProcessors
$diskFree_GB = [math]::Round((Get-PSDrive C).Free / 1GB)

Write-Host "System detected:" -ForegroundColor Cyan
Write-Host "   CPU: $cpuCores cores"
Write-Host "   RAM: $totalRAM_MB MB"
Write-Host "   Disk: $diskFree_GB GB free"
Write-Host ""

# Calculate optimal dbcache based on available RAM
$availableRAM = $totalRAM_MB - 4096
if ($availableRAM -lt 2048) { $availableRAM = 2048 }

$btcCache = [math]::Min(16384, [math]::Max(512, [math]::Floor($availableRAM * 0.30)))
$dogeCache = [math]::Min(8192, [math]::Max(512, [math]::Floor($availableRAM * 0.20)))
$ltcCache = [math]::Min(8192, [math]::Max(512, [math]::Floor($availableRAM * 0.15)))
$nmcCache = [math]::Min(4096, [math]::Max(256, [math]::Floor($availableRAM * 0.10)))
$smallCache = [math]::Min(2048, [math]::Max(256, [math]::Floor($availableRAM * 0.25 / 7)))

Write-Host "Optimized dbcache allocation:" -ForegroundColor Cyan
Write-Host "   Bitcoin:  $btcCache MB"
Write-Host "   Litecoin: $ltcCache MB"
Write-Host "   Dogecoin: $dogeCache MB"
Write-Host "   Namecoin: $nmcCache MB"
Write-Host "   Others:   $smallCache MB each"
Write-Host ""

# Create data directories
Write-Host "Creating data directories..."
$coins = @("bitcoin","litecoin","dogecoin","namecoin","pepecoin","bells","luckycoin","junkcoin","dingocoin","shibacoin","trumpow","pool")
foreach ($coin in $coins) {
    $dir = Join-Path $PSScriptRoot "data\$coin"
    if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
}

# Apply optimized settings to docker-compose.yml
Write-Host "Applying optimized settings..." -ForegroundColor Cyan
$composeFile = Join-Path $PSScriptRoot "docker-compose.yml"
if (Test-Path $composeFile) {
    $content = Get-Content $composeFile -Raw
    $content = $content -replace '-dbcache=8192', "-dbcache=$btcCache"
    $content = $content -replace '-dbcache=4096', "-dbcache=$dogeCache"
    $content = $content -replace '-dbcache=3072', "-dbcache=$smallCache"
    $content = $content -replace '-dbcache=512', "-dbcache=$smallCache"
    $content = $content -replace '-maxconnections=1000', '-maxconnections=0'
    Set-Content $composeFile $content
    Write-Host "[OK] Settings optimized for your system" -ForegroundColor Green
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
Write-Host "  Optimized for your system:" -ForegroundColor Yellow
Write-Host "     $cpuCores CPU cores, ${totalRAM_MB}MB RAM"
Write-Host "     Unlimited peer connections"
Write-Host "     Auto-tuned dbcache per daemon"
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
