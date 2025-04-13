from fastapi import HTTPException
from typing import List
from .models import RecipeDetailModel
from database.query import query_get

def get_recipe_details_by_recipe_id(recipe_id: int) -> List[RecipeDetailModel]:
    details = query_get("SELECT * FROM recipe_details WHERE recipe_id = %s", (recipe_id,))
    return details