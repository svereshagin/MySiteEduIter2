from datetime import datetime
from pathlib import Path
from typing import Annotated, Optional, Any

from pydantic import BaseModel, ConfigDict, Field
from fastapi import UploadFile, File

from ..core.schemas import PersistentDeletion, TimestampSchema, UUIDSchema


class ClassWorkBase(BaseModel):
    title: Annotated[str, Field(min_length=2, max_length=50, examples=["This is my classwork"])]
    comment: Annotated[str, Field(min_length=0, max_length=10000, examples=["This is my comment"])]
    file: UploadFile = File()


class ClassWork(TimestampSchema, ClassWorkBase, UUIDSchema, PersistentDeletion):
    created_by_user_id: int


class ClassWorkRead(BaseModel):
    id: int
    created_by_user_id: int
    title: str
    comment: str
    file_path: str
    file_name: str
    file_size: int
    uuid: Any
    created_at: datetime
    updated_at: datetime | None
    deleted_at: datetime | None
    is_deleted: bool

    class Config:
        from_attributes = True  # Allow mapping from SQLAlchemy models

class ClassWorkCreate(BaseModel):
    title: Annotated[str, Field(min_length=2, max_length=50, examples=["This is my classwork"])]
    comment: Annotated[str, Field(min_length=0, max_length=10000, examples=["This is my comment"])]
    file_path: Path | str = Field(description="Путь до файла")
    file_name: Annotated[str, Field(min_length=0, max_length=50, examples=["This is my file"])]
    file_size: Annotated[int, Field(description="file size")]
    created_by_user_id: int
    
    model_config = ConfigDict(extra="forbid")


class ClassWorkCreateInternal(BaseModel):
    title: Annotated[str, Field(min_length=2, max_length=50, examples=["This is my classwork"])]
    comment: Annotated[str, Field(min_length=0, max_length=10000, examples=["This is my comment"])]
    file: str = Field(..., description="Путь к файлу")  # Changed to str for file path
    created_by_user_id: int
    model_config = ConfigDict(extra="forbid")


class ClassWorkUpdate(BaseModel):
    model_config = ConfigDict(extra="forbid")
    title: Annotated[Optional[str], Field(None, min_length=2, max_length=50, examples=["Updated classwork title"])]
    comment: Annotated[Optional[str], Field(None, min_length=0, max_length=10000, examples=["Updated comment"])]
    file: Optional[UploadFile] = Field(None, description="Новый файл до 5 МБ")


class ClassWorkUpdateInternal(BaseModel):
    title: Annotated[Optional[str], Field(None, min_length=2, max_length=50, examples=["Updated classwork title"])]
    comment: Annotated[Optional[str], Field(None, min_length=0, max_length=10000, examples=["Updated comment"])]
    file: Optional[str] = Field(None, description="Путь к новому файлу")  # Changed to str for file path
    updated_at: datetime
    model_config = ConfigDict(extra="forbid")


class ClassWorkDelete(BaseModel):
    model_config = ConfigDict(extra="forbid")
    is_deleted: bool
    deleted_at: datetime
