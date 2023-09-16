import 'package:flutter/material.dart';
import 'package:uno_project/features/posts/ui/posts_page.dart';



void main() async{ 
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, 
      home: PostsPage(),
    );
  }
}