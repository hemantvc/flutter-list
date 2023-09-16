import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uno_project/blocs/post_bloc.dart';
import 'package:uno_project/screens/post_detail.dart';
 

class PostList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PostLoaded) {
            final posts = state.posts;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(posts[index].title),
                  onTap: () {
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
          } else if (state is PostError) {
            return Center(child: Text('Error: ${state.error}'));
          } else {
            return Center(child: Text('No posts available.'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<PostBloc>(context).add(FetchPosts());
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
