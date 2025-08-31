import uuid as uuid_pkg
from datetime import UTC, datetime

from sqlalchemy import DateTime, ForeignKey, String, LargeBinary, Integer
from sqlalchemy.orm import Mapped, mapped_column

from ..core.db.database import Base


class ClassWork(Base):
    __tablename__ = "classwork"

    id: Mapped[int] = mapped_column("id", autoincrement=True, nullable=False, unique=True, primary_key=True, init=False)
    created_by_user_id: Mapped[int] = mapped_column(ForeignKey("user.id"), index=True)
    title: Mapped[str] = mapped_column(String(30))
    comment: Mapped[str] = mapped_column(String(63206))
    file_path: Mapped[str] = mapped_column(String(300), nullable=False)  # Для хранения файла в базе
    file_name: Mapped[str] = mapped_column(String(255), nullable=False)  # Имя файла
    file_size: Mapped[int] = mapped_column(Integer, nullable=False)  # Размер файла в байтах
    uuid: Mapped[uuid_pkg.UUID] = mapped_column(default_factory=uuid_pkg.uuid4, primary_key=True, unique=True)

    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), default_factory=lambda: datetime.now(UTC))
    updated_at: Mapped[datetime | None] = mapped_column(DateTime(timezone=True), default=None)
    deleted_at: Mapped[datetime | None] = mapped_column(DateTime(timezone=True), default=None)
    is_deleted: Mapped[bool] = mapped_column(default=False, index=True)
