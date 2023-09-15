import 'package:flutter/material.dart';
import 'package:uno_project/models/my_comment.dart';
import 'package:uno_project/providers/post_provider.dart';
import 'package:provider/provider.dart';
import 'package:uno_project/models/my_item.dart';

class PostDetail extends StatelessWidget {
  final MyItem post;

  PostDetail({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post.title),
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
            Text(post.title),
            SizedBox(height: 16),
            Text(
              'Body:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(post.body),
            SizedBox(height: 16),
            // FutureBuilder<List<MyComment>>(
            //   future: Provider.of<PostProvider>(context, listen: false).fetchComments(post.id),
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return Center(child: CircularProgressIndicator());
            //     } else if (snapshot.hasError) {
            //       return Center(child: Text('Error: ${snapshot.error}'));
            //     } else if (snapshot.hasData) {
            //       final comments = snapshot.data;
            //       return Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text(
            //             'Comments:',
            //             style: TextStyle(
            //               fontWeight: FontWeight.bold,
            //               fontSize: 18,
            //             ),
            //           ),
            //           for (final comment in comments!)
            //             ListTile(
            //               title: Text(comment.name),
            //               subtitle: Text(comment.body),
            //               trailing: Text(comment.email),
            //             ),
            //         ],
            //       );
            //     } else {
            //       return Center(child: Text('No comments available.'));
            //     }
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
