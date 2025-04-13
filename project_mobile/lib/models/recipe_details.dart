//Class RecipeDetailsModel สำหรับเก็บข้อมูลเกี่ยวกับวิธีและขั้นตอนการทำอาหารตาม recipe_id
class RecipeDetailsModel {
  final int id;
  final int recipe_id;
  final String ingredients;
  final String steps;
  RecipeDetailsModel(this.id, this.recipe_id, this.ingredients, this.steps);

  RecipeDetailsModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        recipe_id = json['recipe_id'],
        ingredients = json['ingredients'],
        steps = json['steps'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'recipe_id': recipe_id,
      'ingredients': ingredients,
      'steps': steps,
    };
  }
}
