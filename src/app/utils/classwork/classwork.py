import shutil
from pathlib import Path

from fastapi import UploadFile, HTTPException
from sqlalchemy.ext.asyncio import AsyncSession

from ...core.config import path_to_files
from ...models.classwork import ClassWork
from ...schemas.classwork import ClassWorkCreateInternal


ALLOWED_CONTENT_TYPES = [
    "text/x-python",
    "text/x-python-script",
    "application/x-python-code",  # Python
    "application/javascript",
    "text/javascript",  # JavaScript
    "text/x-java-source",
    "text/x-java",  # Java
    "text/x-c",
    "text/x-csrc",  # C
    "text/x-c++",
    "text/x-c++src",  # C++
    "text/plain",  # Текстовые файлы
    "application/pdf",  # PDF
    "application/octet-stream",  # MD
]


async def handle_upload_and_create(
        file: UploadFile,
        username: str,
        title: str,
) -> tuple:
    """
    Хэндлер: принимает UploadFile из FastAPI, сохраняет файл и создает запись в БД.
    """

    # сохраняем файл на диск
    size = file.size
    if size == 0:
        raise HTTPException(status_code=400, detail="Файл пустой")
    if file.content_type not in ALLOWED_CONTENT_TYPES:
        raise HTTPException(
            status_code=400,
            detail=f"Недопустимый тип файла: {file.content_type}. Разрешены только файлы следующих типов: {', '.join(ALLOWED_CONTENT_TYPES)}",
        )
    user_dir = path_to_files / username / title
    user_dir.mkdir(parents=True, exist_ok=True)
    dest_path =  user_dir / file.filename
    with dest_path.open("wb") as buffer:
        shutil.copyfileobj(file.file, buffer)

    # создаём схему Internal для работы с БД
    return size, dest_path