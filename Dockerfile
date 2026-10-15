FROM ghcr.io/project-osrm/osrm-backend:latest

WORKDIR /data

COPY start.sh /start.sh

RUN chmod +x /start.sh

CMD ["/start.sh"]
