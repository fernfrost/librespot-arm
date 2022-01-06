#!/bin/sh

if [ "$INSIDE_DOCKER_CONTAINER" != "1" ]; then
    echo "Must be run in docker container"
    exit 1
fi

curl https://sh.rustup.rs -sSf | sh -s -- -y
export PATH="/root/.cargo/bin/:$PATH"

mkdir -p /.cargo
echo '[target.arm-unknown-linux-gnueabihf]\nlinker = "gcc-wrapper"' > /.cargo/config
rustup target add arm-unknown-linux-gnueabihf

cd /build

git clone git://github.com/librespot-org/librespot.git

cd librespot

cargo build --target=arm-unknown-linux-gnueabihf --release --no-default-features --features alsa-backend

rm -rf /mnt/src/bin
mkdir /mnt/src/bin
cp -v ./target/arm-unknown-linux-gnueabihf/release/librespot /mnt/src/bin/

chown -R "$UID:$GID" /mnt/src/bin 2> /dev/null || true