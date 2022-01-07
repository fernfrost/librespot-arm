build:
	docker build -t librespot-arm .

	docker run \
			--rm \
			--volume "$(CURDIR):/mnt/src" \
			--env UID="$$(id -u)" \
			--env GID="$$(id -g)" \
			librespot-arm /mnt/src/build.sh

clean:
	rm -rf bin
