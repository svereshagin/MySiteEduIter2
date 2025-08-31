from fastcrud import FastCRUD
from ..models.classwork import ClassWork
from ..schemas.classwork import (
    ClassWorkCreateInternal,
    ClassWorkDelete,
    ClassWorkRead,
    ClassWorkUpdate,
    ClassWorkUpdateInternal,
)

CRUDPost = FastCRUD[
    ClassWork, ClassWorkCreateInternal, ClassWorkUpdate, ClassWorkUpdateInternal, ClassWorkDelete, ClassWorkRead
]
crud_classwork = CRUDPost(ClassWork)
