# Makefile для управления Docker и Docker Compose

# Переменные
COMPOSE_FILE ?= docker-compose.yml
PROJECT_NAME ?= backendproggyit

# Удаление всех неиспользуемых Docker-ресурсов (images, builds, volumes)
clean:
	@echo "Очистка неиспользуемых Docker-ресурсов..."
	# Остановка и удаление всех контейнеров проекта
	-docker-compose -f $(COMPOSE_FILE) -p $(PROJECT_NAME) down --remove-orphans
	# Удаление всех неиспользуемых образов
	-docker image prune -a -f
	# Удаление всех неиспользуемых volumes
	-docker volume prune -f
	# Удаление всех неиспользуемых build cache
	-docker builder prune -f
	@echo "Очистка завершена."

# Сборка нового Docker-образа с принудительным пересозданием
build:
	@echo "Сборка нового Docker-образа..."
	# Принудительная пересборка без кэша
	docker-compose -f $(COMPOSE_FILE) -p $(PROJECT_NAME) build --no-cache
	@echo "Сборка завершена."

# Полная очистка и пересборка
rebuild: clean build
	@echo "Полная очистка и пересборка завершены."

# Помощь
help:
	@echo "Доступные команды:"
	@echo "  make clean   - Удаляет все неиспользуемые Docker images, builds и volumes"
	@echo "  make build   - Собирает новый Docker-образ через docker-compose (без кэша)"
	@echo "  make rebuild - Выполняет clean и build последовательно"
	@echo "  make help    - Показывает это сообщение"

.PHONY: clean build rebuild help