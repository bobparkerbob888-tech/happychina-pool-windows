# HappyChina Mining Pool - Windows

Multi-coin SHA-256 + Scrypt mining pool with merge mining. One-click launcher for Windows.

## Prerequisites

- [Docker Desktop for Windows](https://www.docker.com/products/docker-desktop/) (free)
- ~1.75TB disk space for full blockchain sync

## One-Click Start

1. Download this repo (click **Code → Download ZIP** and extract)
2. Double-click **`Start-HappyChinaPool.bat`**
3. That's it! Your browser will open to the dashboard automatically

The launcher will:
- Check if Docker Desktop is installed (opens download page if not)
- Start Docker Desktop if it's not running
- Create all data directories
- Pull and start all containers
- Open http://localhost:8080 in your browser

## Stop the Pool

Double-click **`Stop-HappyChinaPool.bat`**

## Stratum Ports

| Port | Algorithm | Primary Coin | Merge-Mined Coins |
|------|-----------|-------------|-------------------|
| 3342 | SHA-256   | Bitcoin (BTC) | Namecoin (NMC) |
| 3333 | Scrypt    | Litecoin (LTC) | DOGE, PEPE, BELLS, LKY, JKC, DINGO, SHIC, TRMP |

Connect your miners:
- **SHA-256 ASICs**: `stratum+tcp://YOUR_PC_IP:3342`
- **Scrypt ASICs**: `stratum+tcp://YOUR_PC_IP:3333`

Use your wallet address as the username.

## Getting Started

1. The dashboard opens automatically at http://localhost:8080
2. Register an account (first user becomes admin)
3. Set wallet addresses in your profile
4. Connect your miners!

## Supported Coins (11 total)

### SHA-256 (port 3342)
- **Bitcoin (BTC)** — primary chain
- **Namecoin (NMC)** — merge-mined with BTC

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
