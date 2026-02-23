# HappyChina Mining Pool - Windows

Multi-coin Scrypt mining pool with merge mining. One-click launcher for Windows.

## Prerequisites

- [Docker Desktop for Windows](https://www.docker.com/products/docker-desktop/) (free)
- ~900GB disk space for full blockchain sync

## One-Click Start

1. Download this repo (click **Code → Download ZIP** and extract)
2. Double-click **`Start-HappyChinaPool.bat`**
3. That's it! Your browser will open to the dashboard automatically

### ⚠️ Windows SmartScreen Warning

If you see **"Windows protected your PC"** or **"This app can't run on your PC"**:

**Option A - Unblock the .bat file:**
1. Right-click `Start-HappyChinaPool.bat`
2. Click **Properties**
3. At the bottom, check **"Unblock"**
4. Click **OK**
5. Double-click the .bat file again

**Option B - Use PowerShell instead:**
1. Right-click `Start-HappyChinaPool.ps1`
2. Select **"Run with PowerShell"**
3. If prompted about execution policy, type `Y` and press Enter

**Option C - Run from Command Prompt:**
1. Open Command Prompt (Win+R → `cmd` → Enter)
2. Navigate to the extracted folder: `cd C:\Users\YourName\Downloads\happychina-pool-windows-main`
3. Run: `Start-HappyChinaPool.bat`

The launcher will:
- Check if Docker Desktop is installed (opens download page if not)
- Start Docker Desktop if it's not running
- **Auto-detect** your system's CPU, RAM, and disk space
- **Auto-tune** dbcache per daemon based on your RAM for fastest sync
- Set **unlimited peer connections** for all daemons
- Create all data directories
- Pull and start all containers
- Open http://localhost:8080 in your browser

## Stop the Pool

Double-click **`Stop-HappyChinaPool.bat`**

## Stratum Ports

| Port | Algorithm | Primary Coin | Merge-Mined Coins |
|------|-----------|-------------|-------------------|
| 3333 | Scrypt    | Litecoin (LTC) | DOGE, PEPE, BELLS, LKY, JKC, DINGO, SHIC, TRMP |

Additional ports:
- **3344**: Low difficulty (CPU/GPU miners)

Connect your miners:
- **Scrypt ASICs**: `stratum+tcp://YOUR_PC_IP:3333`

Use your wallet address as the username.

## Getting Started

1. The dashboard opens automatically at http://localhost:8080
2. Register an account (first user becomes admin)
3. Set wallet addresses in your profile
4. Connect your miners!

## Supported Coins (9 total)

### Scrypt (port 3333)
- **Litecoin (LTC)** — primary chain
- **Dogecoin (DOGE)** — merge-mined with LTC
- **Pepecoin (PEPE)** — merge-mined with LTC
- **Bells (BELLS)** — merge-mined with LTC
- **Luckycoin (LKY)** — merge-mined with LTC
- **Junkcoin (JKC)** — merge-mined with LTC
- **Dingocoin (DINGO)** — merge-mined with LTC
- **Shibacoin (SHIC)** — merge-mined with LTC
- **TrumPOW (TRMP)** — merge-mined with LTC

## Other Versions

- **Umbrel**: [happychina-pool-umbrel](https://github.com/bobparkerbob888-tech/happychina-pool-umbrel)
- **Ubuntu/Linux**: [happychina-pool-ubuntu](https://github.com/bobparkerbob888-tech/happychina-pool-ubuntu)
