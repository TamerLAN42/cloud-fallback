#!/bin/sh

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

terraform init -input=false

while true; do
    if [ -f /shared/LOCK_STATE ]; then
	    log "LOCK_STATE found. Something bad happened?"
        if grep -q "^true$" /shared/LOCK_STATE; then
		    log "nah, we're just re-running. Going to sleep, waiting for re-installation."
			log "Please be warn: LOCK_STATE deletion will both re-install all setup, and !!DESTROY THE VM!!. Dont delete it till you move all stuff you need back to host"
            while [ -f /shared/LOCK_STATE ]; do
                sleep 5
            done
            terraform destroy --auto-approve
			sleep 5
            exit 0
        else
		    log "HOST DEAD, activating phoenix-protocol, moving app to cloud"
            terraform apply --auto-approve
            echo "true" > /shared/LOCK_STATE
			sleep 5
            exit 0
        fi
    fi
    sleep 5
done