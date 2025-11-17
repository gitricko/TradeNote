

mongo-start:
	docker compose -f ./docker-compose-local.yml up -d mongo

mongo-stop:
	docker compose -f ./docker-compose-local.yml down mongo

mongo-restart: mongo-stop mongo-start

mongo-reset: mongo-stop
	docker rm -f tradenote_db
	mongo-start