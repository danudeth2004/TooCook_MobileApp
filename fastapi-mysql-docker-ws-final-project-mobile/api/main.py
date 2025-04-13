from fastapi import FastAPI, HTTPException, status
from fastapi.middleware.cors import CORSMiddleware

from cooking_methods.cooking_methods import get_all_methods
from recipes.recipes import get_all_recipes, get_recipes_by_method_id, add_comment_to_recipe
from recipe_details.recipe_details import get_recipe_details_by_recipe_id
from cooking_methods.models import CookingMethodModel
from recipes.models import RecipeModel
from recipe_details.models import RecipeDetailModel

from typing import List

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"], 
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
async def root():
    return {"message": "Welcome to TooCook!"}

@app.get("/cooking_methods", response_model=List[CookingMethodModel])
async def read_cooking_methods():
    try:
        methods = get_all_methods()
        return methods
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    
@app.get("/recipes/all", response_model=List[RecipeModel])
async def read_all_recipes():
    try:
        recipes = get_all_recipes()
        return recipes
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.get("/recipes/{method_id}", response_model=List[RecipeModel])
async def read_recipes_by_method(method_id: int):
    try:
        recipes = get_recipes_by_method_id(method_id)
        return recipes
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.post("/recipes/{recipe_id}/comments", status_code=status.HTTP_201_CREATED)
async def add_comment(recipe_id: int, new_comment: str):
    try:
        success = add_comment_to_recipe(recipe_id, new_comment)
        if success:
            return {"message": "Comment added successfully"}
        raise HTTPException(status_code=500, detail="Failed to add comment")
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.get("/recipe_details/{recipe_id}", response_model=List[RecipeDetailModel])
async def read_recipe_details(recipe_id: int):
    try:
        details = get_recipe_details_by_recipe_id(recipe_id)
        return details
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
