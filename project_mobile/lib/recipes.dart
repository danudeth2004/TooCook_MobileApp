import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project_mobile/components/bottom_nav_bar.dart';
import 'package:project_mobile/models/cooking_methods.dart';
import 'package:project_mobile/models/recipes.dart';
import 'package:project_mobile/recipe_details.dart';

//ใช้ StatefulWidget เพราะมีการ get ข้อมูลจาก api
class Recipes extends StatefulWidget {
  final CookingMethodsModel cookingMethods;

  const Recipes({
    super.key,
    required this.cookingMethods,
  });

  @override
  State<Recipes> createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {
  List<RecipesModel> recipesModel = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      var response = await http.get(
        Uri.parse('http://localhost:8800/recipes/${widget.cookingMethods.id}'),
      );
      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(utf8.decode(response.bodyBytes));
        setState(() {
          recipesModel =
              jsonList.map((item) => RecipesModel.fromJson(item)).toList();
        });
      } else {
        throw Exception("Failed to load Recipes");
      }
    } catch (e) {
      print(e);
    }
  }

  //สร้าง UI หน้าจอ โดยใช้ Expanded ในการขยายพื้นที่ให้กับ ListView.builder ภายในจะแสดงตามจำนวน recipesModel.length โดยแต่ละ recipesModel แสดงเป็น Card ภายในจะมีรูปภาพเมนู ชื่อ และคำอธิบาย ที่ใช้ inkWell เพื่อให้สามารถ click ไปทีี่ Card เพื่อส่งค่า recipesModel[index] ไปให้กับ recipe_details เพื่อแสดงผลตามเมนูที่กด
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(selectedIndex: 1),
      appBar: AppBar(
        title: Text(
          "เมนู" + "${widget.cookingMethods.method_name}",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 5),
            Expanded(
              child: ListView.builder(
                itemCount: recipesModel.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeDetails(recipesModel: recipesModel[index]),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                recipesModel[index].image_url ?? '',
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    recipesModel[index].recipe_name,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    recipesModel[index].description ?? 'ไม่มีคำอธิบาย',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(fontSize: 18),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 4,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
