
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/my_comment.dart';
import '../models/my_item.dart';
import 'dart:convert';


class PostDetail extends StatefulWidget {
  final MyItem post;

  PostDetail({required this.post});

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  Future<List<MyComment>> fetchComments(int postId) async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/comments?postId=$postId'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      List<MyComment> comments = data.map((item) => MyComment.fromJson(item)).toList();
      return comments;
    } else {
      throw Exception('Failed to load comments');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(widget.post.title),
            SizedBox(height: 16),
            Text(
              'Body:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(widget.post.body),
            SizedBox(height: 16),
            FutureBuilder<List<MyComment>>(
              future: fetchComments(widget.post.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Comments:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      for (final comment in snapshot.data!)
                        ListTile(
                          title: Text(comment.name),
                          subtitle: Text(comment.body),
                          trailing: Text(comment.email),
                        ),
                    ],
                  );
                } else {
                  return Text('No comments available.');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}