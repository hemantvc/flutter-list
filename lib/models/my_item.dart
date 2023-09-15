class MyItem {
  final int id;
  final String title;
  final String body;

  MyItem({
    required this.id,
    required this.title,
    required this.body,
  });

  factory MyItem.fromJson(Map<String, dynamic> json) {
    return MyItem(
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }
}