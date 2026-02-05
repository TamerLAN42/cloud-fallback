#!/bin/sh
ALLOWED_FAILS="${ALLOWED_FAILS:-5}"
CHECK_TIMEOUT="${CHECK_TIMEOUT:-30}"
FAIL_COUNT=0
CHECK_URL="${CHECK_URL:-http://${CHECK_HOST}:${CHECK_PORT:-80}}"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

if [ -f "/shared/LOCK_STATE" ]; then
    log "./shared/LOCK_STATE found. Delete it to confirm reinstallation of health-check script."
	log "Please be warn: LOCK_STATE deletion will both re-install all setup, and !!DESTROY THE VM!!. Dont delete it till you move all stuff you need back to host"
    log "Are you a human? Or a broken cycled script? I'm not sure, so i'm going to sleep."
    while [ -f "/shared/LOCK_STATE" ]; do 
	    sleep 30; 
    done
fi

if [ "$(stat -c %a "/shared" 2>/dev/null)" != "777" ]; then
    chmod -R 777 /shared 2>/dev/null
	log "Fixed permisions on /shared"
fi

if [ -n "$CHECK_URL" ]; then
    (
    while true; do
        if curl -s -f -I --max-time 5 "${CHECK_URL}"; then
		    log "Status OK, waiting till next check"
			FAIL_COUNT=0
            sleep "${CHECK_TIMEOUT}"
        else
		    FAIL_COUNT=$((FAIL_COUNT + 1))
            log "Status BAD, total sequential errors: ${FAIL_COUNT}, max allowed errors: ${ALLOWED_FAILS}"
			if [ $FAIL_COUNT -gt $ALLOWED_FAILS ]; then
			    log "Status KILLED, host presumed dead, started Phoenix-protocol and quit checking"
			    touch /shared/LOCK_STATE
				sleep 3
				kill -TERM 1
			fi
            sleep "${CHECK_TIMEOUT}"
        fi
    done ) &
fi

log "starting ssh daemon"
exec /usr/sbin/sshd -D -e