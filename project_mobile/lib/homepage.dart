import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project_mobile/components/bottom_nav_bar.dart';
import 'package:project_mobile/models/cooking_methods.dart';
import 'package:project_mobile/recipes.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<CookingMethodsModel> cookingMethods = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      var response = await http.get(
        Uri.parse('http://localhost:8800/cooking_methods'),
      );
      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(utf8.decode(response.bodyBytes));
        setState(() {
          cookingMethods =
              jsonList.map((item) => CookingMethodsModel.fromJson(item)).toList();
        });
      } else {
        throw Exception("Failed to load cooking methods");
      }
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(selectedIndex: 1,),
      body: Column(
        children: [
          SizedBox(height: 80),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: AssetImage('assets/homepage_logo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                height: 250,
              ),
            ],
          ),
          SizedBox(height: 30),
          Text(
            "เลือกวิธีที่คุณชอบได้เลย",
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontSize: 30),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                itemCount: cookingMethods.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  String imagePath = _getImagePath(
                    cookingMethods[index].method_name,
                  );
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder:(context) => Recipes(cookingMethods: cookingMethods[index]),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: AssetImage(imagePath),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.black.withOpacity(0.1),
                          ),
                        ),
                        Center(
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                            ),
                            child: Text(
                              "เมนู" + cookingMethods[index].method_name,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String _getImagePath(String methodName) {
  switch (methodName) {
    case 'ทอด':
      return 'assets/toad.jpeg';
    case 'ต้ม':
      return 'assets/tom.jpeg';
    case 'นึ่ง':
      return 'assets/nung.jpeg';
    case 'ยำ':
      return 'assets/yum.jpeg';
    default:
      return '';
  }
}
