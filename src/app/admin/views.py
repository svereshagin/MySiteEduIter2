from typing import Annotated

from crudadmin import CRUDAdmin
from crudadmin.admin_interface.model_view import PasswordTransformer
from pydantic import BaseModel, Field, field_validator, model_validator, ConfigDict

from ..core.security import get_password_hash
from ..models.post import Post
from ..models.tier import Tier
from ..models.user import User
from ..models.classwork import ClassWork
from ..schemas.post import PostUpdate
from ..schemas.tier import TierCreate, TierUpdate
from ..schemas.user import UserCreate, UserUpdate
from ..schemas.classwork import ClassWorkCreate, ClassWorkUpdate, ClassWorkRead


class PostCreateAdmin(BaseModel):
    title: Annotated[str, Field(min_length=2, max_length=30, examples=["This is my post"])]
    text: Annotated[str, Field(min_length=1, max_length=63206, examples=["This is the content of my post."])]
    created_by_user_id: int
    media_url: Annotated[
        str | None,
        Field(pattern=r"^(https?|ftp)://[^\s/$.?#].[^\s]*$", examples=["https://www.postimageurl.com"], default=None),
    ]


from pydantic import BaseModel, ConfigDict, Field, EmailStr, model_validator
from typing import Annotated
from ..core.security import get_password_hash




class UserCreateAdmin(BaseModel):
    model_config = ConfigDict(extra="ignore")  

    username: Annotated[str, Field(min_length=3, max_length=50, examples=["johndoe"])]
    name: Annotated[str, Field(min_length=2, max_length=100, examples=["John Doe"])]
    email: Annotated[EmailStr, Field(examples=["john.doe@example.com"])]
    hashed_password: str | None = None  # Optional; will be hashed if provided

    @field_validator("hashed_password", mode="before")
    @classmethod
    def hash_incoming_value(cls, value: str | None) -> str | None:
        """Hash the incoming value if provided."""
        if value is not None:
            return get_password_hash(value)  
        return value 
    
    
    
def register_admin_views(admin: CRUDAdmin) -> None:
    """Register all models and their schemas with the admin interface.

    This function adds all available models to the admin interface with appropriate
    schemas and permissions.
    """

    # password_transformer = PasswordTransformer(
    #     password_field="password",
    #     hashed_field="hashed_password",
    #     hash_function=get_password_hash,
    #     required_fields=["name", "username", "email"],
    # )

    admin.add_view(
        model=User,
        create_schema=UserCreateAdmin,
        update_schema=UserUpdate,
        allowed_actions={"view", "create", "update"},
        #password_transformer=password_transformer,
    )

    admin.add_view(
        model=Tier,
        create_schema=TierCreate,
        update_schema=TierUpdate,
        allowed_actions={"view", "create", "update", "delete"},
    )

    admin.add_view(
        model=Post,
        create_schema=PostCreateAdmin,
        update_schema=PostUpdate,
        allowed_actions={"view", "create", "update", "delete"},
    )

    admin.add_view(
        model=ClassWork,
        create_schema=ClassWorkRead,
        update_schema=ClassWorkUpdate,
        allowed_actions={"view", "create", "update", "delete"},
    )
