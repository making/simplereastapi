FROM ubuntu:jammy as builder

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    curl \
    tar \
    unzip \
    zip \
    libssl-dev\
    ninja-build \
    g++ \
    pkg-config

RUN git clone https://github.com/microsoft/vcpkg.git /vcpkg && \
    cd /vcpkg && \
    ./bootstrap-vcpkg.sh

RUN /vcpkg/vcpkg install cpp-httplib nlohmann-json

WORKDIR /app

COPY main.cpp CMakeLists.txt ./

RUN mkdir build && cd build && \
    cmake .. -DCMAKE_TOOLCHAIN_FILE=/vcpkg/scripts/buildsystems/vcpkg.cmake && \
    cmake --build .

FROM gcr.io/distroless/cc-debian12
USER 1000:1000

COPY --from=builder --chown=1000:1000 /app/build/SimpleRESTAPI /app/build/SimpleRESTAPI
CMD ["/app/build/SimpleRESTAPI"]

