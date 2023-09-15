import 'package:flutter/material.dart';
import 'package:uno_project/providers/post_provider.dart';
import 'package:provider/provider.dart';
import 'package:uno_project/screens/post_detail.dart';

class PostList extends StatefulWidget {
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  void initState() {
    super.initState();
    Provider.of<PostProvider>(context, listen: false).fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: Consumer<PostProvider>(
        builder: (context, provider, child) {
          final posts = provider.posts;
          if (posts.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(posts[index].title),
                  onTap: () {
                    Provider.of<PostProvider>(context, listen: false).fetchComments(posts[index].id);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostDetail(post: posts[index]),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
