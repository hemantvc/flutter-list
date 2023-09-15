import 'package:flutter/material.dart';
import 'package:uno_project/providers/post_provider.dart';
import 'package:uno_project/screens/post_list.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter JSON Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        create: (_) => PostProvider(),
        child: PostList(),
      ),
    );
  }
}
