import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uno_project/listener/server_response_listener.dart';
import 'package:uno_project/server/http_service.dart';
import 'package:uno_project/server/model/all_post_rs.dart';
import 'package:uno_project/ui/base_screen.dart';
import 'package:uno_project/ui/comment_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({required Key key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends BaseScreen<MainScreen> {
  List<Post> allPost = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // load ui after run this task
      //call web api
      _callAllPost();
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
          itemCount: allPost.length,
          itemBuilder: (context, index) {
            return Expanded(
              child: SingleChildScrollView(
                child: ListView.separated(
                  itemCount: allPost.length,
                  padding: const EdgeInsets.only(
                      top: 20.0, bottom: 10.0, left: 20.0, right: 20.0),
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CommentsScreen(
                                  title: allPost[index].title!,
                                  postId: allPost[index].id!,
                                  key: UniqueKey(),
                                )));
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('Title: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Expanded(
                                  child: Text(
                                    allPost[index].title!,
                                    maxLines: 1, // Limit to a single line
                                    overflow: TextOverflow
                                        .ellipsis, // Truncate text with ellipsis if it exceeds 1 line
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Body: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Expanded(
                                  child: Text(
                                    allPost[index].body!,
                                    maxLines: 3,
                                    overflow: TextOverflow
                                        .ellipsis, // Truncate text with ellipsis if it exceeds 3 lines.
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 1.0,
                      color: Colors.blue,
                      margin: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                    );
                  },
                ),
              ),
            );
          },
        )
      ]),
    );
  }

  /// all post web api call
  _callAllPost() {
    showProgress();

    var listener = ServerResponseListener(onConnectionError: (String message) {
      hideProgress();
    }, onResponse: (dynamic response) async {
      hideProgress();
      AllPostRs allPostRs = AllPostRs.fromJson(json.decode(response));
      if (allPostRs.allPost != null) {
        setState(() {
          allPost = allPostRs.allPost!;
        });
      }
    }, onFailure: (dynamic response) {
      hideProgress();
    }, onError: (dynamic response) {
      hideProgress();
    }, onUnauthorizedError: (dynamic response) {
      hideProgress();
    });

    HttpService.callAllPost(listener);
  }
}
