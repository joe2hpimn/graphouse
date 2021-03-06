#!/usr/bin/env bash
set -e

service nginx start
export PYTHONPATH=/opt/graphite/webapp

exec /usr/local/bin/gunicorn wsgi --bind=127.0.0.1:8080 --log-file=/var/log/gunicorn.log \
    --preload --pythonpath=/opt/graphite/webapp/graphite \
    --worker-class=${GUNICORN_WORKER_CLASS:-'gthread'} \
    --workers=${GUNICORN_WORKERS:-8} --threads=${GUNICORN_THREADS:-4} \
    --max-requests=${GUNICORN_MAX_REQUSTS:-10000} --max-requests-jitter=${GUNICORN_MAX_REQUSTS_JITTER:-2000} \
    --timeout=${GUNICORN_TIMEOUT:-60} --graceful-timeout=${GUNICORN_GRACEFULL_TIMEOUT:-60} \
    --limit-request-line=${GUNICORN_LIMIT_REQUEST_LINE:-8190}
