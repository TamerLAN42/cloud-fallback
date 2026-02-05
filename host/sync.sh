#!/bin/sh
SSH_PORT="${SSH_PORT:-53182}"
SOURCE_DIR="/data"
BACKUP_DIR="backup"
BACKUP_HOST="$BACKUP_HOST"
BACKUP_USER="${BACKUP_USER:-tunnel}"
KEY_FILE="${KEY_FILE:-id_ed25519}"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

log "Starting sync"

if [ -z "$BACKUP_HOST" ] || [ -z "$BACKUP_USER" ]; then
    log "ERROR: BACKUP_HOST or BACKUP_USER not set"
    exit 1
fi

if [ ! -f /root/.ssh/known_hosts ]; then
    mkdir -p /root/.ssh
    ssh-keyscan -p "${SSH_PORT}" -H $BACKUP_HOST > /root/.ssh/known_hosts 2>/dev/null
	log "Not found any known hosts, added $BACKUP_HOST fingerprint"
fi

if [ -f /root/.ssh/$KEY_FILE ]; then
    chown root:root /root/.ssh/$KEY_FILE 2>/dev/null
    chmod 600 /root/.ssh/$KEY_FILE
fi
if [ -f /root/.ssh/known_hosts ]; then
    chmod 600 /root/.ssh/known_hosts
fi

if ! ssh -o ConnectTimeout=5 -p ${SSH_PORT} "${BACKUP_USER}@${BACKUP_HOST}" exit; then
    log "SSH connection failed"
    exit 1
fi

if rsync -avz --delete --timeout=30 --no-owner --no-group --chmod=ugo=rwX --no-times -e "ssh -o ConnectTimeout=5 -p ${SSH_PORT}" "$SOURCE_DIR/" "${BACKUP_USER}@${BACKUP_HOST}:/shared/${BACKUP_DIR}/"; then
    log "Sync Completed Successfully"
else
    log "Sync Failed"
    exit 1
fi