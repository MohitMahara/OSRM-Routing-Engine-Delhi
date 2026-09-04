# OSRM Docker Microservice - Delhi

![Docker](https://img.shields.io/badge/Docker-Ready-2496ED?logo=docker&logoColor=white)
![OSRM](https://img.shields.io/badge/OSRM-v5.27-blue)
![Region](https://img.shields.io/badge/Region-Delhi_NCR-success)
![RAM](https://img.shields.io/badge/RAM_Required-<512MB-orange)

A plug-and-play, containerized Open Source Routing Machine (OSRM) engine tailored specifically for the New Delhi region. 

This repository contains the **pre-compiled** geospatial graph data and the Dockerfile required to spin up an enterprise-grade routing API in seconds. By pre-compiling the map, this container bypasses the heavy CPU/RAM requirements of standard OSRM extraction, allowing it to be deployed on free, low-resource serverless platforms (Render, Koyeb, AWS Free Tier).

## Features
- **Zero-Build Compilation:** Map data is pre-processed using the MLD (Multi-Level Dijkstra) algorithm.
- **Ultra-Low Resource:** Can run smoothly on free-tier 512MB RAM instances.
- **Car Profile Optimized:** Configured for standard four-wheeler street routing.
- **Smart Compression:** Graph data is compressed via `.tar.gz` to bypass GitHub's 100MB file limit. The graph automatically extracts during the Docker build phase.
- **Drop-in Google Maps Alternative:** Returns distance, ETAs, and GeoJSON polylines for free.

---

## Quick Start (Run Locally)

If you have Docker installed, you can start the routing engine locally in three simple commands.

### 1. Clone the repository
```bash
git clone https://github.com/MohitMahara/OSRM-Routing-Engine-Delhi.git
cd OSRM-Routing-Engine-Delhi
```

### 2. Build the Docker Image
Because the graph data is compressed to bypass GitHub limits, Docker will automatically extract the `.tar.gz` file during this build step to prepare the engine.
```bash
docker build -t osrm-routing-engine-delhi .
```

### 3. Start the Server
Since the map data is now baked directly into the image, you do not need to mount any local folders. Just bind the port and run the container:
```bash
docker run -p 5000:5000 osrm-routing-engine-delhi
```

The routing API is now live and listening for requests at `http://localhost:5000`.

---

## API Usage

Once the container is running, you can hit the standard OSRM HTTP API. 

**Calculate a Route (Connaught Place to India Gate):**
```http
GET http://localhost:5000/route/v1/driving/77.2167,28.6328;77.2295,28.6129?overview=full&geometries=geojson
```

**JSON Response Example:**
```json
{
  "code": "Ok",
  "routes": [
    {
      "distance": 3540.5,
      "duration": 420.2,
      "geometry": {
        "coordinates": [
          [77.2167, 28.6328],
          [77.2178, 28.6331]
        ],
        "type": "LineString"
      }
    }
  ]
}
```