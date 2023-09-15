import 'package:flutter/material.dart';
import 'package:uno_project/screens/post_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter JSON Example',
      home: PostList(),
    );
  }
}
