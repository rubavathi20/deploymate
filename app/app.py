from flask import Flask, jsonify
import socket
import datetime

app = Flask(__name__)


@app.route("/")
def home():
    return jsonify({
        "application": "DeployMate",
        "message": "Automated Cloud Deployment & Monitoring Platform",
        "status": "running"
    })


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


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
