from pydantic import BaseModel
from typing import Optional

class CookingMethodModel(BaseModel):
    id: Optional[int] = None
    method_name: str