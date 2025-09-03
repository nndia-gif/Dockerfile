#!/bin/sh
set -e


# Railway biasanya set $PORT untuk HTTP/WSS. Default 9001 kalau lokal.
PORT_WS=${PORT:-9001}


# Optional auth pakai ENV MQTT_USERNAME & MQTT_PASSWORD
AUTH_CONFIG="allow_anonymous true"
if [ -n "$MQTT_USERNAME" ] && [ -n "$MQTT_PASSWORD" ]; then
mosquitto_passwd -b -c /mosquitto/config/passwd "$MQTT_USERNAME" "$MQTT_PASSWORD"
AUTH_CONFIG="password_file /mosquitto/config/passwd\nallow_anonymous false"
fi


# Tulis konfigurasi mosquitto
cat > /mosquitto/config/mosquitto.conf <<EOF
persistence true
persistence_location /mosquitto/data/
log_dest stdout


# Listener TCP untuk device (ESP32, dsb)
listener 1883 0.0.0.0
${AUTH_CONFIG}


# Listener WebSocket untuk client web (akan diexpose sebagai HTTPS/WSS oleh Railway)
listener ${PORT_WS} 0.0.0.0
protocol websockets
EOF


# Jalankan broker
exec mosquitto -c /mosquitto/config/mosquitto.conf
