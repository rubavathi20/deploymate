from flask import Flask, jsonify
import os

app = Flask(__name__)

VERSION = "1.0.0"


@app.route("/")
def home():
    return jsonify({
        "application": "DeployMate",
        "message": "DeployMate application is running",
        "version": VERSION
    })


@app.route("/health")
def health():
    return jsonify({
        "status": "healthy",
        "application": "DeployMate",
        "version": VERSION
    })


@app.route("/version")
def version():
    return jsonify({
        "version": VERSION
    })


if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.run(host="0.0.0.0", port=port)
