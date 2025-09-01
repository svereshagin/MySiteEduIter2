import logging
import os
import stat
from logging.handlers import RotatingFileHandler

# Путь к директории логов
LOG_DIR = os.path.join(os.path.dirname(os.path.dirname(__file__)), "logs")
LOG_FILE_PATH = os.path.join(LOG_DIR, "app.log")

# Создание директории с явными правами (rwxr-xr-x, 755)
if not os.path.exists(LOG_DIR):
    os.makedirs(LOG_DIR, mode=0o755, exist_ok=True)

# Установка прав для лог-файла (rw-r--r--, 644)
LOGGING_LEVEL = logging.INFO
LOGGING_FORMAT = "%(asctime)s - %(name)s - %(levelname)s - %(message)s"

# Настройка базового логгера
logging.basicConfig(level=LOGGING_LEVEL, format=LOGGING_FORMAT)

# Настройка RotatingFileHandler
file_handler = RotatingFileHandler(LOG_FILE_PATH, maxBytes=10485760, backupCount=5)
file_handler.setLevel(LOGGING_LEVEL)
file_handler.setFormatter(logging.Formatter(LOGGING_FORMAT))

# Установка прав на лог-файл (если он создаётся)
if not os.path.exists(LOG_FILE_PATH):
    open(LOG_FILE_PATH, 'a').close()  # Создаём пустой файл
    os.chmod(LOG_FILE_PATH, stat.S_IRUSR | stat.S_IWUSR | stat.S_IRGRP | stat.S_IROTH)  # 644

logging.getLogger("").addHandler(file_handler)
