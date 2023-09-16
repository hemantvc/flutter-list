class PostCommentsRs {
  List<Comment>? postComments;

  PostCommentsRs({required this.postComments});

  PostCommentsRs.fromJson(dynamic json) {
    postComments = <Comment>[];
    json.forEach((v) {
      postComments?.add(Comment.fromJson(v));
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (postComments != null) {
      data['postComments'] = postComments?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comment {
  int? postId;
  int? id;
  String? name;
  String? email;
  String? body;

  Comment({required this.postId,required this.id,required this.name,required this.email,required this.body});

  Comment.fromJson(Map<String, dynamic> json) {
    postId = json['postId'];
    id = json['id'];
    name = json['name'];
    email = json['email'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postId'] = this.postId;
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['body'] = this.body;
    return data;
  }
}
