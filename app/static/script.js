async function loadMetrics() {

    try {

        const response = await fetch("/api/metrics");
        const data = await response.json();

        document.getElementById("status").textContent =
            data.status.toUpperCase();

        document.getElementById("cpu").textContent =
            data.cpu + "%";

        document.getElementById("memory").textContent =
            data.memory + "%";

        document.getElementById("disk").textContent =
            data.disk;

        document.getElementById("uptime").textContent =
            data.uptime;

        document.getElementById("hostname").textContent =
            data.hostname;

        document.getElementById("timestamp").textContent =
            new Date(data.timestamp).toLocaleString();

    } catch (error) {

        document.getElementById("status").textContent = "DOWN";

        console.error("Monitoring error:", error);
    }
}


loadMetrics();

setInterval(loadMetrics, 5000);
