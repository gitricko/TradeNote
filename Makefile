.PHONY: node-env-prep mongo-start mongo-stop mongo-restart mongo-reset node-build dev-start

mongo-start:
	docker compose -f ./docker-compose-local.yml up -d mongo

mongo-stop:
	docker compose -f ./docker-compose-local.yml down mongo

mongo-restart: mongo-stop mongo-start

mongo-reset: mongo-stop
	docker rm -f tradenote_db
	$(MAKE) mongo-start

node-env-prep:
	. $$NVM_DIR/nvm.sh; nvm install 18
	. $$NVM_DIR/nvm.sh; nvm use 18
	. $$NVM_DIR/nvm.sh; nvm use 18; npm install

node-build: node-env-prep
	. $$NVM_DIR/nvm.sh; nvm use 18; npm run build

dev-start: mongo-start node-build
	. $$NVM_DIR/nvm.sh; nvm use 18; \
	MONGO_URI=mongodb://tradenote:tradenote@localhost:27017/tradenote?authSource=admin \
	TRADENOTE_DATABASE=tradenote APP_ID=123456 MASTER_KEY=123456 TRADENOTE_PORT=8080 \
	npm run start