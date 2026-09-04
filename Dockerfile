FROM ghcr.io/project-osrm/osrm-backend

WORKDIR /data

COPY map-graph.tar.gz.part* ./

RUN cat map-graph.tar.gz.part* > map-graph.tar.gz && \
    tar -xzvf map-graph.tar.gz && \
    rm map-graph.tar.gz*

EXPOSE 5000

CMD ["osrm-routed", "--algorithm", "mld", "/data/delhi-graph/new-delhi.osrm"]