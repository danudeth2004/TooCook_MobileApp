import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_mobile/components/bottom_nav_bar.dart';
import 'package:project_mobile/models/recipes.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RecipeDetails extends StatefulWidget {
  final RecipesModel recipesModel;

  const RecipeDetails({super.key, required this.recipesModel});

  @override
  State<RecipeDetails> createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
  String ingredients = '';
  String steps = '';
  List<String> comments = [];
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    comments = List.from(widget.recipesModel.comment ?? []);
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      var response = await http.get(
        Uri.parse(
          'http://localhost:8800/recipe_details/${widget.recipesModel.id}',
        ),
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        setState(() {
          ingredients = data[0]['ingredients'];
          steps = data[0]['steps'];
        });
      } else {
        throw Exception("Failed to load Recipe details");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> postComment() async {
    final comment = _commentController.text.trim();
    if (comment.isEmpty) return;

    try {
      final response = await http.post(
        Uri.parse(
          'http://localhost:8800/recipes/${widget.recipesModel.id}/comments?new_comment=$comment',
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'new_comment': comment}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          comments.add(comment);
          _commentController.clear();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'โพสต์คอมเมนต์สำเร็จ',
              style: TextStyle(fontSize: 20),
            ),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        throw Exception("Failed to post Recipe details");
      }
    } catch (e) {
      print("Post comment error: $e");
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final videoUrl = widget.recipesModel.youtube_url ?? '';
    final videoId = videoUrl.isNotEmpty ? videoUrl.split('v=')[1] : null;
    final youtubeUrl =
        videoId != null ? 'https://www.youtube.com/embed/$videoId' : null;

    return Scaffold(
      bottomNavigationBar: BottomNavBar(selectedIndex: 1),
      appBar: AppBar(title: Text(widget.recipesModel.recipe_name)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 230,
                child: WebView(
                  initialUrl: youtubeUrl,
                  javascriptMode: JavascriptMode.unrestricted,
                ),
              ),
              const SizedBox(height: 16),
              Text("วัตถุดิบ", style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  ingredients,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontSize: 18),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "ขั้นตอนการทำ",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      steps
                          .split('\n')
                          .map(
                            (line) => Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Text(
                                line,
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.copyWith(fontSize: 18),
                              ),
                            ),
                          )
                          .toList(),
                ),
              ),

              const SizedBox(height: 24),
              Text("คอมเมนต์", style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 8),
              TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  hintText: "แสดงความคิดเห็น...",
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                style: const TextStyle(fontSize: 18),
                maxLines: 2,
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: postComment,
                child: const Text("โพสต์", style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 16),
              ...comments.reversed.map(
                (comment) => Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.person_pin_sharp),
                    title: Text(comment, style: const TextStyle(fontSize: 18)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
