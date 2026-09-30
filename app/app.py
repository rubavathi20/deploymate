from flask import Flask, jsonify, render_template
import socket
import datetime
import os
import re

app = Flask(__name__)


@app.route("/")
def dashboard():
    return render_template("dashboard.html")


@app.route("/health")
def health():
    return jsonify({
        "status": "healthy"
    })


@app.route("/api/status")
def status():
    return jsonify({
        "application": "DeployMate",
        "hostname": socket.gethostname(),
        "timestamp": datetime.datetime.utcnow().isoformat(),
        "status": "running"
    })


@app.route("/api/metrics")
def metrics():

    metrics_file = "reports/system_metrics.txt"

    cpu = "N/A"
    memory = "N/A"
    disk = "N/A"
    uptime = "N/A"
    health_status = "unhealthy"

    try:
        if os.path.exists(metrics_file):

            with open(metrics_file, "r") as file:
                content = file.read()

            cpu_match = re.search(r"CPU Usage:\s*([\d.]+)%", content)
            memory_match = re.search(r"Memory Usage:\s*([\d.]+)%", content)
            disk_match = re.search(r"Disk Usage:\s*(\d+%)", content)
            uptime_match = re.search(r"Uptime:\s*(.+)", content)
            health_match = re.search(
                r'Application Health:\s*\{"status":"healthy"\}',
                content
            )

            if cpu_match:
                cpu = cpu_match.group(1)

            if memory_match:
                memory = memory_match.group(1)

            if disk_match:
                disk = disk_match.group(1)

            if uptime_match:
                uptime = uptime_match.group(1).strip()

            if health_match:
                health_status = "healthy"

    except Exception as error:
        print("Monitoring error:", error)

    return jsonify({
        "application": "DeployMate",
        "status": health_status,
        "cpu": cpu,
        "memory": memory,
        "disk": disk,
        "uptime": uptime,
        "hostname": socket.gethostname(),
        "timestamp": datetime.datetime.utcnow().isoformat()
    })


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
