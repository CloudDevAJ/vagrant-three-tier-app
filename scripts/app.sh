#!/bin/bash
set -e

echo "=== Installing Python and Flask on App VM ==="

apt-get update
apt-get install -y python3 python3-pip python3-venv

mkdir -p /opt/app

python3 -m venv /opt/app/venv

/opt/app/venv/bin/pip install --upgrade pip
/opt/app/venv/bin/pip install flask mysql-connector-python==8.0.28

cat > /opt/app/app.py <<'PY'
from flask import Flask
import mysql.connector

app = Flask(__name__)

DB_CONFIG = {
    "host": "192.168.56.12",
    "user": "appuser",
    "password": "AppPassword123!",
    "database": "appdb",
}


@app.route("/")
def home():
    db_status = "not checked"

    try:
        conn = mysql.connector.connect(**DB_CONFIG)

        cursor = conn.cursor()
        cursor.execute("SELECT VERSION()")

        version = cursor.fetchone()[0]

        cursor.close()
        conn.close()

        db_status = f"MySQL connected - version {version}"

    except Exception as e:
        db_status = f"MySQL connection failed: {e}"

    return f"""
    <html>
        <head>
            <title>Vagrant Three-Tier Lab</title>
        </head>

        <body>
            <h1>Application VM</h1>
            <p>Flask application is running.</p>
            <p>{db_status}</p>
        </body>
    </html>
    """


@app.route("/health")
def health():
    return "APP OK"


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
PY

cat > /etc/systemd/system/flaskapp.service <<'EOF'
[Unit]
Description=Vagrant Flask Application
After=network.target

[Service]
User=root
WorkingDirectory=/opt/app
ExecStart=/opt/app/venv/bin/python /opt/app/app.py
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable flaskapp
systemctl restart flaskapp

echo "=== App VM ready ==="