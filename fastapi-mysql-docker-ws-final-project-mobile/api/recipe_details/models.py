from pydantic import BaseModel
from typing import Optional

class RecipeDetailModel(BaseModel):
    id: Optional[int] = None
    recipe_id: int
    ingredients: str
    steps: str