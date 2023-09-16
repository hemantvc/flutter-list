// lib/bloc/post_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:uno_project/models/post.dart';

// Events
abstract class PostEvent {}

class FetchPosts extends PostEvent {}

class SelectPost extends PostEvent {
  final Post selectedPost;

  SelectPost({required this.selectedPost});
}

// States
abstract class PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<Post> posts;

  PostLoaded({required this.posts});
}

class PostSelected extends PostState {
  final Post selectedPost;

  PostSelected({required this.selectedPost});
}

class PostError extends PostState {
  final String error;

  PostError({required this.error});
}

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostLoading());
  

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
     print('Fetching posts...1');
    if (event is FetchPosts) {
      yield PostLoading();
      try {
        final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
         print('Fetching posts...2');
        if (response.statusCode == 200) {
          final List<dynamic> data = json.decode(response.body);
          final List<Post> posts = data.map((item) => Post.fromJson(item)).toList();
          yield PostLoaded(posts: posts);
        } else {
          yield PostError(error: 'Failed to load posts');
        }
      } catch (e) {
          print('Fetching posts...2');
        yield PostError(error: 'An error occurred: $e');
      }
    } else if (event is SelectPost) {
        print('Fetching posts...2');
      yield PostSelected(selectedPost: event.selectedPost);
    }
  }
}
