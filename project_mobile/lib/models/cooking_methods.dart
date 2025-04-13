class CookingMethodsModel {
  final int id;
  final String method_name;
  CookingMethodsModel(this.id, this.method_name);

  CookingMethodsModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        method_name = json['method_name'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'method_name': method_name,
    };
  }
}