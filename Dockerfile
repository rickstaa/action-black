FROM python:3-slim

ENV PYTHONDONTWRITEBYTECODE 1 \
    PYTHONUNBUFFERED 1

RUN  python -m venv venv && . venv/bin/activate &&  pip install --upgrade pip && venv/bin/pip install --upgrade --no-cache-dir black==23.11.0

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
