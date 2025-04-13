from fastapi import HTTPException
from typing import List
from .models import CookingMethodModel
from database.query import query_get

def get_all_methods() -> List[CookingMethodModel]:
    methods = query_get("SELECT * FROM cooking_methods ORDER BY id ASC", ())
    return methods