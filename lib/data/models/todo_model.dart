class TodoModel {
  int? id;
  String uid;
  String title;
  String body;
  DateTime? createdAt;

  TodoModel({
    this.id,
    this.createdAt,
    required this.uid,
    required this.title,
    required this.body,
  });

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map["id"],
      uid: map["uid"],
      title: map["title"],
      body: map["body"],
      createdAt: DateTime.parse(map["created_at"]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "title": title,
      "body": body,
    };
  }
}
