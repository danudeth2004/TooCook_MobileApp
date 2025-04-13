from pydantic import BaseModel
from typing import Optional, List

class RecipeModel(BaseModel):
    id: Optional[int] = None
    recipe_name: str
    description: Optional[str] = None
    image_url: Optional[str] = None
    youtube_url: Optional[str] = None
    method_id: int
    comment: Optional[List[str]] = None