#!/bin/bash
set -e

export UWSGI_WSGI=gapid:app
export UWSGI_HTTP=:8000

cd "$APP_DIR"
exec uwsgi --show-config
