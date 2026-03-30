FROM cr.agentgateway.dev/agentgateway:v1.0.1 AS agentgateway

FROM debian:trixie-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    caddy \
    supervisor \
    && rm -rf /var/lib/apt/lists/*

COPY --from=agentgateway /app/agentgateway /app/agentgateway
RUN chmod +x /app/agentgateway

WORKDIR /app

COPY config.yaml /data/config.yaml.default
COPY Caddyfile /etc/caddy/Caddyfile
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENV PATH="/app:${PATH}"
CMD ["/entrypoint.sh"]
