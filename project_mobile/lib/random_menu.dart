import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_mobile/components/bottom_nav_bar.dart';
import 'package:project_mobile/models/recipes.dart';
import 'package:project_mobile/recipe_details.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

//ใช้ StatefulWidget เพราะมีการเปลี่ยนแปลงสถานะการสุ่ม และการ get ข้อมูลจาก api
class RandomMenu extends StatefulWidget {
  const RandomMenu({super.key});

  @override
  State<RandomMenu> createState() => _RandomMenuState();
}

//เก็บ recipesModel เพื่อที่จะส่ง recipesModel ไปให้กับหน้า recipe_details[id] ในการแสดงเมนูที่ถูกต้อง
class _RandomMenuState extends State<RandomMenu> {
  List<RecipesModel> recipesModel = [];
  final StreamController<int> streamController = StreamController<int>();
  int? selectedIndex;
  bool showResultAfterSpin = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }

  Future<void> fetchData() async {
    try {
      var response = await http.get(
        Uri.parse('http://localhost:8800/recipes/all'),
      );
      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(utf8.decode(response.bodyBytes));
        setState(() {
          recipesModel =
              jsonList.map((item) => RecipesModel.fromJson(item)).toList();
        });
      } else {
        throw Exception("Failed to load All Recipes");
      }
    } catch (e) {
      print(e);
    }
  }

  // ฟังก์ชันสุ่ม index จากชื่อเมนูใน recipesModel
  void spinWheel() {
    if (recipesModel.isNotEmpty) {
      final index = Random().nextInt(recipesModel.length);
      setState(() {
        selectedIndex = index;
        showResultAfterSpin = false;
      });
      streamController.add(index);
    }
  }

  //สร้างวงล้อสุ่มโดยจะแสดงผลชื่อเมนูที่สุ่มได้ก็ต่อเมื่อ showResultAfterSpin = true และจะแสดงทั้งชื่อเมนูและปุ่มสำหรับกดเข้าไปในหน้า recipes_details ของเมนูที่สุ่มได้
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(selectedIndex: 0),
      appBar: AppBar(title: const Text('Random Menu')),
      body: recipesModel.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : recipesModel.length < 2
              ? const Center(
                  child: Text(
                    'กรุณาเพิ่มเมนูอย่างน้อย 2 รายการเพื่อใช้งานวงล้อสุ่ม',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Expanded(
                        child: FortuneWheel(
                          selected: streamController.stream,
                          items: recipesModel.map((recipe) {
                            return FortuneItem(
                              child: Text(
                                recipe.recipe_name,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontSize: 16),
                              ),
                            );
                          }).toList(),
                          animateFirst: false,
                          onAnimationEnd: () {
                            setState(() {
                              showResultAfterSpin = true;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: spinWheel,
                        child: const Text(
                          "สุ่มเมนู",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      const SizedBox(height: 24),
                      if (selectedIndex != null && showResultAfterSpin)
                        Column(
                          children: [
                            Text(
                              'คุณสุ่มได้เมนู : ${recipesModel[selectedIndex!].recipe_name}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton.icon(
                              icon: const Icon(
                                Icons.check_circle_outline,
                                size: 25,
                              ),
                              label: const Text(
                                "เลือกเมนูนี้",
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => RecipeDetails(
                                      recipesModel: recipesModel[selectedIndex!],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
    );
  }
}
