# Build Stage
FROM --platform=linux/amd64 ubuntu:20.04 as builder

## Install build dependencies.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y cmake g++ make zlib1g

## Add source code to the build stage.
ADD . /atomicparsley
WORKDIR /atomicparsley

## TODO: ADD YOUR BUILD INSTRUCTIONS HERE.
RUN cmake . && cmake --build . --config Release

# Package Stage
FROM --platform=linux/amd64 ubuntu:20.04

## TODO: Change <Path in Builder Stage>
COPY --from=builder /atomicparsley/AtomicParsley /

