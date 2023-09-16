import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uno_project/blocs/post_bloc.dart';
import 'package:uno_project/models/comment.dart';
import 'package:uno_project/models/post.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostDetail extends StatelessWidget {
  final Post post;

  PostDetail({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Detail'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Title:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(post.title),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Body:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(post.body),
          ),
          BlocBuilder<PostBloc, PostState>(
            builder: (context, state) {
              if (state is PostSelected) {
                return FutureBuilder<List<Comment>>(
                  future: _fetchCommentsForPost(context, state.selectedPost.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final comments = snapshot.data!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'Comments:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          for (final comment in comments)
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
                );
              } else {
                return Container(); // Placeholder
              }
            },
          ),
        ],
      ),
    );
  }

  Future<List<Comment>> _fetchCommentsForPost(BuildContext context, int postId) async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/comments?postId=$postId'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<Comment> comments = data.map((item) => Comment.fromJson(item)).toList();
      return comments;
    } else {
      throw Exception('Failed to load comments');
    }
  }
}
