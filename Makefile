
up_prod:
	docker compose -f docker-compose-prod.yml up -d --build
restart:
	docker compose -f docker-compose-prod.yml down -v
	docker rmi -f mysiteeduiter2-web mysiteeduiter2-worker
	docker builder prune -f
	docker compose -f docker-compose-prod.yml up -d --build

down_prod:
	docker compose -f docker-compose-prod.yml down -v
	docker rmi -f mysiteeduiter2-web mysiteeduiter2-worker
	docker builder prune -f
