
import 'package:flutter/material.dart';
import 'package:uno_project/screens/post_detail.dart';
import '../models/my_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostList extends StatefulWidget {
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  Future<List<MyItem>> fetchPosts() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      List<MyItem> posts = data.map((item) => MyItem.fromJson(item)).toList();
      return posts;
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: FutureBuilder<List<MyItem>>(
        future: fetchPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].title),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostDetail(post: snapshot.data![index]),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return Center(child: Text('No posts available.'));
          }
        },
      ),
    );
  }
}