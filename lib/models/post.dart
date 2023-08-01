class Post {
  int? userId;
  int? id;
  String? title;
  String? body;

  Post({this.userId = 0, this.id = 0, required this.title, required this.body});

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

  String getFirstCharacter() {
    return title![0].toUpperCase();
  }
}
