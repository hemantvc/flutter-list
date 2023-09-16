import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uno_project/listener/server_response_listener.dart';
import 'package:uno_project/server/http_service.dart';
import 'package:uno_project/server/model/posts_comments_rs.dart';
import 'package:uno_project/ui/base_screen.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen(
      {required Key key, required this.title, required this.postId})
      : super(key: key);

  final String title;
  final int postId;

  @override
  State<CommentsScreen> createState() => _CommentsScreenState(this.postId);
}

class _CommentsScreenState extends BaseScreen<CommentsScreen> {
  List<Comment> comments = [];
  final int postId;
  _CommentsScreenState(this.postId);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // load ui after run this task
      //call web api
      _callPostsComments(postId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(children: [
        circularProgressBar(),
        ListView.builder(
          itemCount: comments.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 4.0,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${comments[index].name}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "${comments[index].email}",
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "${comments[index].body}",
                        style: const TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ]),
    );
  }

  /// posts comments web api call
  _callPostsComments(int postId) {
    showProgress();

    var listener = ServerResponseListener(onConnectionError: (String message) {
      hideProgress();
    }, onResponse: (dynamic response) async {
      hideProgress();
      PostCommentsRs postCommentsRs =
          PostCommentsRs.fromJson(json.decode(response));
      if (postCommentsRs.postComments != null) {
        setState(() {
          comments = postCommentsRs.postComments!;
        });
      }
    }, onFailure: (dynamic response) {
      hideProgress();
    }, onError: (dynamic response) {
      hideProgress();
    }, onUnauthorizedError: (dynamic response) {
      hideProgress();
    });

    HttpService.callPostsComments(postId, listener);
  }
}
