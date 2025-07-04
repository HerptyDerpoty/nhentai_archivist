ARG RUST_VERSION="1.86"

FROM rust:$RUST_VERSION AS builder
WORKDIR "/app/"
COPY "." "."
RUN cargo build --release

FROM gcr.io/distroless/cc-debian11:debug
WORKDIR "/app/"
COPY --from=builder "/app/target/release/nhentai_archivist" "."

ENTRYPOINT ["./nhentai_archivist"]


# MANUAL BUILD:

# build docker image, save in tar, remove image so only tar remains
# docker build -t "9-fs/nhentai_archivist:latest" --no-cache . && docker save "9-fs/nhentai_archivist:latest" > "docker-image.tar" && docker rmi "9-fs/nhentai_archivist:latest"

# on deployment environment load docker image from tar file
# docker load < "/mnt/user/appdata/docker-image.tar"