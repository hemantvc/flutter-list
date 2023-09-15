import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:uno_project/models/my_item.dart';
import 'package:uno_project/models/my_comment.dart';

class PostProvider with ChangeNotifier {
  List<MyItem> _posts = [];
  List<MyComment> _comments = [];

  List<MyItem> get posts => _posts;
  List<MyComment> get comments => _comments;

  Future<void> fetchPosts() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      _posts = data.map((item) => MyItem.fromJson(item)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<List<MyComment>> fetchComments(int postId) async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/comments?postId=$postId'));
  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    final List<MyComment> comments = data.map((item) => MyComment.fromJson(item)).toList();
    return comments; // Return the comments list
  } else {
    throw Exception('Failed to load comments');
  }
}

}
