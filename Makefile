restart: down up
down:
	docker compose down
build:
	docker compose up --build
up:
	docker compose up

root:
	docker exec -it movie-reservation-system-app-1 /bin/bash
%:
	@: