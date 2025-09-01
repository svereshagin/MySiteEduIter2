
up_prod:
	docker compose -f docker-compose-prod.yml up -d --build
restart:
	docker compose -f docker-compose-prod.yml down -v
	docker rmi -f mysiteeduiter2-web mysiteeduiter2-worker
	docker builder prune -f
	docker compose -f docker-compose-prod.yml up -d --build

down_localhost:
worker-1  | 2025-08-31 19:22:09,970 - arq.worker - INFO - Starting worker for 1 functions: sample_background_task
worker-1  | 19:22:09: redis_version=8.2.1 mem_usage=1.00M clients_connected=1 db_keys=0
worker-1  | 2025-08-31 19:22:09,973 - arq.worker - INFO - redis_version=8.2.1 mem_usage=1.00M clients_connected=1 db_keys=0
worker-1  | 2025-08-31 19:22:09,973 - root - INFO - Worker Started
redis-1   | 1:M 31 Aug 2025 19:22:07.896 * <ReJSON> Exported RedisJSON_V5 API
redis-1   | 1:M 31 Aug 2025 19:22:07.896 * <ReJSON> Enabled diskless replication
redis-1   | 1:M 31 Aug 2025 19:22:07.896 * <ReJSON> Initialized shared string cache, thread safe: false.
redis-1   | 1:M 31 Aug 2025 19:22:07.896 * Module 'ReJSON' loaded from /usr/local/lib/redis/modules//rejson.so
redis-1   | 1:M 31 Aug 2025 19:22:07.896 * <search> Acquired RedisJSON_V5 API
redis-1   | 1:M 31 Aug 2025 19:22:07.898 * Server initialized
redis-1   | 1:M 31 Aug 2025 19:22:07.898 * Ready to accept connections tcp
nginx-1   | /docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
nginx-1   | /docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
nginx-1   | /docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
nginx-1   | 10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
nginx-1   | 10-listen-on-ipv6-by-default.sh: info: /etc/nginx/conf.d/default.conf differs from the packaged version
nginx-1   | /docker-entrypoint.sh: Sourcing /docker-entrypoint.d/15-local-resolvers.envsh
nginx-1   | /docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
nginx-1   | /docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
nginx-1   | /docker-entrypoint.sh: Configuration complete; ready for start up
nginx-1   | 2025/08/31 19:22:08 [notice] 1#1: using the "epoll" event method
nginx-1   | 2025/08/31 19:22:08 [notice] 1#1: nginx/1.29.1
nginx-1   | 2025/08/31 19:22:08 [notice] 1#1: built by gcc 12.2.0 (Debian 12.2.0-14+deb12u1)
nginx-1   | 2025/08/31 19:22:08 [notice] 1#1: OS: Linux 6.8.0-35-generic
nginx-1   | 2025/08/31 19:22:08 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
nginx-1   | 2025/08/31 19:22:08 [notice] 1#1: start worker processes
nginx-1   | 2025/08/31 19:22:08 [notice] 1#1: start worker process 28
nginx-1   | 2025/08/31 19:22:08 [notice] 1#1: start worker process 29
create_superuser-1  | ERROR:__main__:Error creating admin user: (sqlalchemy.dialects.postgresql.asyncpg.ProgrammingError) <class 'asyncpg.exceptions.UndefinedTableError'>: relation "user" does not exist
create_superuser-1  | [SQL: SELECT "user".id, "user".name, "user".username, "user".email, "user".hashed_password, "user".profile_image_url, "user".uuid, "user".created_at, "user".updated_at, "user".deleted_at, "user".is_deleted, "user".is_superuser, "user".tier_id
create_superuser-1  | FROM "user"
create_superuser-1  | WHERE "user".email = $1::VARCHAR]
create_superuser-1  | [parameters: ('risefenixpuryfire@gmail.com',)]
create_superuser-1  | (Background on this error at: https://sqlalche.me/e/20/f405)
web-1               | INFO:     Will watch for changes in these directories: ['/code']
web-1               | INFO:     Uvicorn running on http://0.0.0.0:8000 (Press CTRL+C to quit)
web-1               | INFO:     Started reloader process [1] using StatReload
web-1               | Process SpawnProcess-1:
web-1               | Traceback (most recent call last):
web-1               |   File "/usr/local/lib/python3.11/multiprocessing/process.py", line 314, in _bootstrap
web-1               |     self.run()
web-1               |   File "/usr/local/lib/python3.11/multiprocessing/process.py", line 108, in run
web-1               |     self._target(*self._args, **self._kwargs)
web-1               |   File "/app/.venv/lib/python3.11/site-packages/uvicorn/_subprocess.py", line 80, in subprocess_started
web-1               |     target(sockets=sockets)
web-1               |   File "/app/.venv/lib/python3.11/site-packages/uvicorn/server.py", line 66, in run
web-1               |     return asyncio.run(self.serve(sockets=sockets))
web-1               |            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
web-1               |   File "/usr/local/lib/python3.11/asyncio/runners.py", line 190, in run
web-1               |     return runner.run(main)
web-1               |            ^^^^^^^^^^^^^^^^
web-1               |   File "/usr/local/lib/python3.11/asyncio/runners.py", line 118, in run
web-1               |     return self._loop.run_until_complete(task)
web-1               |            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
web-1               |   File "uvloop/loop.pyx", line 1518, in uvloop.loop.Loop.run_until_complete
web-1               |   File "/app/.venv/lib/python3.11/site-packages/uvicorn/server.py", line 70, in serve
web-1               |     await self._serve(sockets)
web-1               |   File "/app/.venv/lib/python3.11/site-packages/uvicorn/server.py", line 77, in _serve
web-1               |     config.load()
web-1               |   File "/app/.venv/lib/python3.11/site-packages/uvicorn/config.py", line 435, in load
web-1               |     self.loaded_app = import_from_string(self.app)
web-1               |                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
web-1               |   File "/app/.venv/lib/python3.11/site-packages/uvicorn/importer.py", line 19, in import_from_string
web-1               |     module = importlib.import_module(module_str)
web-1               |              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
web-1               |   File "/usr/local/lib/python3.11/importlib/__init__.py", line 126, in import_module
web-1               |     return _bootstrap._gcd_import(name[level:], package, level)
web-1               |            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
web-1               |   File "<frozen importlib._bootstrap>", line 1204, in _gcd_import
web-1               |   File "<frozen importlib._bootstrap>", line 1176, in _find_and_load
web-1               |   File "<frozen importlib._bootstrap>", line 1147, in _find_and_load_unlocked
web-1               |   File "<frozen importlib._bootstrap>", line 690, in _load_unlocked
web-1               |   File "<frozen importlib._bootstrap_external>", line 940, in exec_module
web-1               |   File "<frozen importlib._bootstrap>", line 241, in _call_with_frames_removed
web-1               |   File "/code/app/main.py", line 7, in <module>
web-1               |     from .api import router
web-1               |   File "/code/app/api/__init__.py", line 3, in <module>
web-1               |     from ..api.v1 import router as v1_router
web-1               |   File "/code/app/api/v1/__init__.py", line 5, in <module>
web-1               |     from .posts import router as posts_router
web-1               |   File "/code/app/api/v1/posts.py", line 7, in <module>
web-1               |     from ...api.dependencies import get_current_superuser, get_current_user
web-1               |   File "/code/app/api/dependencies.py", line 9, in <module>
web-1               |     from ..core.logger import logging
web-1               |   File "/code/app/core/logger.py", line 7, in <module>
web-1               |     os.makedirs(LOG_DIR)
web-1               |   File "<frozen os>", line 225, in makedirs
web-1               | PermissionError: [Errno 13] Permission denied: '/code/app/logs'
db-1                | The files belonging to this database system will be owned by user "postgres".
db-1                | This user must also own the server process.
db-1                |
db-1                | The database cluster will be initialized with locale "en_US.utf8".
db-1                | The default database encoding has accordingly been set to "UTF8".
db-1                | The default text search configuration will be set to "english".
db-1                |
db-1                | Data page checksums are disabled.
db-1                |
db-1                | fixing permissions on existing directory /var/lib/postgresql/data ... ok
db-1                | creating subdirectories ... ok
db-1                | selecting dynamic shared memory implementation ... posix
db-1                | selecting default max_connections ... 100
db-1                | selecting default shared_buffers ... 128MB
db-1                | selecting default time zone ... Etc/UTC
db-1                | creating configuration files ... ok
db-1                | running bootstrap script ... ok
db-1                | performing post-bootstrap initialization ... ok
db-1                | initdb: warning: enabling "trust" authentication for local connections
db-1                | You can change this by editing pg_hba.conf or using the option -A, or
db-1                | --auth-local and --auth-host, the next time you run initdb.
db-1                | syncing data to disk ... ok
db-1                |
db-1                |
db-1                | Success. You can now start the database server using:
db-1                |
db-1                |     pg_ctl -D /var/lib/postgresql/data -l logfile start
db-1                |
db-1                | waiting for server to start....2025-08-31 19:22:10.101 UTC [47] LOG:  starting PostgreSQL 13.22 (Debian 13.22-1.pgdg13+1) on x86_64-pc-linux-gnu, compiled by gcc (Debian 14.2.0-19) 14.2.0, 64-bit
db-1                | 2025-08-31 19:22:10.104 UTC [47] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
db-1                | 2025-08-31 19:22:10.118 UTC [48] LOG:  database system was shut down at 2025-08-31 19:22:09 UTC
db-1                | 2025-08-31 19:22:10.135 UTC [47] LOG:  database system is ready to accept connections
db-1                |  done
db-1                | server started
db-1                | CREATE DATABASE
db-1                |
db-1                |
db-1                | /usr/local/bin/docker-entrypoint.sh: ignoring /docker-entrypoint-initdb.d/*
db-1                |
db-1                | waiting for server to shut down....2025-08-31 19:22:10.578 UTC [47] LOG:  received fast shutdown request
db-1                | 2025-08-31 19:22:10.580 UTC [47] LOG:  aborting any active transactions
db-1                | 2025-08-31 19:22:10.588 UTC [47] LOG:  background worker "logical replication launcher" (PID 54) exited with exit code 1
db-1                | 2025-08-31 19:22:10.592 UTC [49] LOG:  shutting down
db-1                | 2025-08-31 19:22:10.618 UTC [47] LOG:  database system is shut down
db-1                |  done
db-1                | server stopped
db-1                |
db-1                | PostgreSQL init process complete; ready for start up.
db-1                |
db-1                | 2025-08-31 19:22:10.750 UTC [1] LOG:  starting PostgreSQL 13.22 (Debian 13.22-1.pgdg13+1) on x86_64-pc-linux-gnu, compiled by gcc (Debian 14.2.0-19) 14.2.0, 64-bit
db-1                | 2025-08-31 19:22:10.751 UTC [1] LOG:  listening on IPv4 address "0.0.0.0", port 5432
db-1                | 2025-08-31 19:22:10.751 UTC [1] LOG:  listening on IPv6 address "::", port 5432
db-1                | 2025-08-31 19:22:10.756 UTC [1] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
db-1                | 2025-08-31 19:22:10.764 UTC [62] LOG:  database system was shut down at 2025-08-31 19:22:10 UTC
db-1                | 2025-08-31 19:22:10.781 UTC [1] LOG:  database system is ready to accept connections
db-1                | 2025-08-31 19:22:11.560 UTC [69] ERROR:  relation "user" does not exist at character 244
db-1                | 2025-08-31 19:22:11.560 UTC [69] STATEMENT:  SELECT "user".id, "user".name, "user".username, "user".email, "user".hashed_password, "user".profile_image_url, "user".uuid, "user".created_at, "user".updated_at, "user".deleted_at, "user".is_deleted, "user".is_superuser, "user".tier_id
db-1                |   FROM "user"
db-1                |   WHERE "user".email = $1::VARCHAR
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
