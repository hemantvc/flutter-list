class MyComment {
  final int id;
  final int postId;
  final String name;
  final String email;
  final String body;

  MyComment({
    required this.id,
    required this.postId,
    required this.name,
    required this.email,
    required this.body,
  });

  factory MyComment.fromJson(Map<String, dynamic> json) {
    return MyComment(
      id: json['id'] as int,
      postId: json['postId'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      body: json['body'] as String,
    );
  }
}