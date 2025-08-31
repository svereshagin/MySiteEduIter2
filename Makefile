
up_prod:
	docker compose -f docker-compose-prod.yml up -d --build
restart:
	docker compose -f docker-compose-prod.yml down -v
	docker rmi -f mysiteeduiter2-web mysiteeduiter2-worker
	docker builder prune -f
	docker compose -f docker-compose-prod.yml up -d --build

down_localhost:
	docker compose  down -v
	docker rmi -f mysiteeduiter2-web mysiteeduiter2-worker
	docker builder prune -f
	docker volume prune
up_localhost:
	docker compose -f docker-compose-prod.yml up -d --build
restart:
	docker compose down -v
	docker rmi -f mysiteeduiter2-web mysiteeduiter2-worker
	docker builder prune -f
	docker compose up -d --build
# HELP
.PHONY: help
help: ## Show this help message
	@echo "Usage: make [command]"
	@echo ""
	@echo "Commands:"
	@awk 'BEGIN {FS = ":.*?## "; section=""; prev_section=""} \
		/^[#].*/ { \
			section = substr($$0, 3); \
		} \
		/^[a-zA-Z0-9_-]+:.*?## / { \
			if (section != prev_section) { \
				print ""; \
				print "\033[1;34m" section "\033[0m"; \
				prev_section = section; \
			} \
			gsub(/\\n/, "\n                      \t\t"); \
			printf " \x1b[36;1m%-28s\033[0m%s\n", $$1, $$2; \
		}' $(MAKEFILE_LIST)
