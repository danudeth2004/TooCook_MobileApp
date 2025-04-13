//Class RecipesModel สำหรับเก็บข้อมูลเกี่ยวกับประเภทของการทำอาหาร
class RecipesModel {
  final int id;
  final String recipe_name;
  final String? description;
  final String? image_url;
  final String? youtube_url;
  final int method_id;
  final List<String>? comment;

  RecipesModel(
    this.id,
    this.recipe_name,
    this.description,
    this.image_url,
    this.youtube_url,
    this.method_id,
    this.comment,
  );

  factory RecipesModel.fromJson(Map<String, dynamic> json) {
    return RecipesModel(
      json['id'],
      json['recipe_name'],
      json['description'],
      json['image_url'],
      json['youtube_url'],
      json['method_id'],
      json['comment'] != null ? List<String>.from(json['comment']) : null,
    );
  }
}