FROM eclipse-mosquitto:2.0

# copy config ke dalam container
COPY mosquitto.conf /mosquitto/config/mosquitto.conf

# Expose ports untuk MQTT TCP & WebSocket
EXPOSE 1883
EXPOSE 9001
