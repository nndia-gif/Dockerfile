FROM eclipse-mosquitto:2.0


# Entrypoint akan bikin mosquitto.conf dinamis (sesuai ENV)
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh


# Expose TCP MQTT
EXPOSE 1883
# WebSocket akan listen di $PORT (Railway akan handle TLS & domain)


ENTRYPOINT ["/entrypoint.sh"]
