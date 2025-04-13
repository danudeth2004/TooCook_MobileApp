from fastapi import HTTPException
from typing import List
from .models import RecipeModel
from database.query import query_get, query_update
import json

def get_all_recipes() -> List[RecipeModel]:
    recipes = query_get("SELECT * FROM recipes ORDER BY id ASC", ())
    for recipe in recipes:
        if recipe["comment"]:
            try:
                recipe["comment"] = json.loads(recipe["comment"])
            except json.JSONDecodeError:
                recipe["comment"] = []
        else:
            recipe["comment"] = []
    return recipes

def get_recipes_by_method_id(method_id: int) -> List[RecipeModel]:
    recipes = query_get("SELECT * FROM recipes WHERE method_id = %s ORDER BY id ASC", (method_id,))
    for recipe in recipes:
        if recipe["comment"]:
            try:
                recipe["comment"] = json.loads(recipe["comment"])
            except json.JSONDecodeError:
                recipe["comment"] = []
        else:
            recipe["comment"] = []
    return recipes

def add_comment_to_recipe(recipe_id: int, new_comment: str) -> bool:
    result = query_get("SELECT comment FROM recipes WHERE id = %s", (recipe_id,))
    current_comment = result[0]["comment"]
    if current_comment:
        try:
            comments = json.loads(current_comment)
        except json.JSONDecodeError:
            comments = []
    else:
        comments = []
    comments.append(new_comment)
    
    sql = "UPDATE recipes SET comment = %s WHERE id = %s"
    return query_update(sql, (json.dumps(comments, ensure_ascii=False), recipe_id))
