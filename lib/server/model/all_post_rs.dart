class AllPostRs {
  List<Post>? allPost;

  AllPostRs({required this.allPost});

  AllPostRs.fromJson(dynamic json) {
    allPost = <Post>[];
    json.forEach((v) {
      allPost?.add(Post.fromJson(v));
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (allPost != null) {
      data['allPost'] = this.allPost?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Post {
  int? userId;
  int? id;
  String? title;
  String? body;

  Post({required this.userId,required this.id,required this.title,required this.body});

  Post.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}
