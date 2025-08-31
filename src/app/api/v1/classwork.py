import shutil
from http.client import HTTPException
from pathlib import Path
from typing import Annotated, Any, cast

from fastapi import APIRouter, Depends, Request, UploadFile, File, HTTPException, Form
from fastapi.params import Query
from fastapi.security import HTTPAuthorizationCredentials, HTTPBearer
from fastcrud.exceptions.http_exceptions import UnauthorizedException
from fastcrud.paginated import PaginatedListResponse, compute_offset, paginated_response
from sqlalchemy.ext.asyncio import AsyncSession
from starlette.responses import FileResponse

from ...api.dependencies import get_current_superuser, get_current_user
from ...core.config import path_to_files
from ...core.db.database import async_get_db
from ...core.exceptions.http_exceptions import ForbiddenException, NotFoundException
from ...core.security import verify_token, TokenType
from ...core.utils.cache import cache
from ...crud.crud_classworks import crud_classwork
from ...crud.crud_users import crud_users
from ...schemas.classwork import (
    ClassWorkRead,
    ClassWorkUpdate,
    ClassWorkDelete,
    ClassWorkCreate,
    ClassWorkCreateInternal,
    ClassWorkBase,
    ClassWork,
)
from ...schemas.user import UserRead
from ...utils.classwork.classwork import handle_upload_and_create

router = APIRouter(tags=["classworks"])
# Список разрешённых MIME-типов


@router.post("/classwork/")
async def create_upload_file(
    request: Request,
    db: Annotated[AsyncSession, Depends(async_get_db)],
    title: str = Form(..., min_length=2, max_length=50),
    comment: str = Form(..., min_length=0, max_length=10000),
    username: dict = Depends(get_current_user),
    file: UploadFile = File(...),
):
    username = username.get('username')
    db_user = await crud_users.get(
        db=db, username=username, is_deleted=False, schema_to_select=UserRead, return_as_model=True
    )
    if db_user is None:
        raise NotFoundException("User not found")
    print(db_user)
    size, dest_path = await handle_upload_and_create(file, username, title)
    classwork = await crud_classwork.create(
        db=db,object=ClassWorkCreate(
            title=title,
            comment=comment,
            file_path=str(dest_path),
            file_name=file.filename,
            file_size=size,
            created_by_user_id=db_user.id,
        ))

    return {'result': True}



@router.get("/classwork/")
async def get_classworks(
        db: Annotated[AsyncSession, Depends(async_get_db)],
        username_str: Annotated[str, Query(..., description="Username of the user")],
        #current_user: dict = Depends(get_current_user),  # Optional: for authentication
        
):
    # Optional: Restrict access to authenticated user or admin
    # if not current_user.get("username"):
    #     raise HTTPException(status_code=401, detail="Недействительный токен")
    # if current_user.get("username") != username_str and not current_user.get("is_admin"):
    #     raise HTTPException(status_code=403, detail="Недостаточно прав")

    # Verify user existence
    db_user = await crud_users.get(
        db=db,
        username=username_str,
        is_deleted=False,
        schema_to_select=UserRead,
        return_as_model=True
    )
    if db_user is None:
        raise HTTPException(status_code=404, detail="User not found")

    # Fetch all classworks for the user, excluding deleted ones
    classworks = await crud_classwork.get_multi(
        db=db,
        created_by_user_id=db_user.id,  # Filter by user ID
        is_deleted=False,  # Exclude soft-deleted records
        schema_to_select=ClassWorkRead,
        return_as_model=False  # Return as dict, not custom object
    )
    
    return {
        # "result": True,
        "data": classworks,  # Use 'items' instead of 'data'
        # "total": classworks["total"] if "total" in classworks else len(classworks["items"])
    }

@router.get("/classwork/view/")
async def get_classworks(
        file_path: Annotated[str, Query(..., description="Username of the user")]):
    file = path_to_files / file_path
    if not file.exists():
        raise HTTPException(status_code=404, detail="File not found")
    media_type = "application/octet-stream"
    if file_path.endswith(('.jpg', '.jpeg', '.png')):
        media_type = f"image/{file_path.split('.')[-1]}"
    elif file_path.endswith('.pdf'):
        media_type = "application/pdf"

    return FileResponse(
        path=str(file),
        media_type=media_type,
        filename=file_path
    )