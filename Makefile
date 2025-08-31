
up_prod:
	docker compose -f docker-compose-prod.yml up -d --build

down_prod:
	docker compose -f docker-compose-prod.yml down -v