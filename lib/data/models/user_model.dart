class UserModel {
  String uid;
  String email;
  String? imageUrl;
  DateTime? createdAt;

  UserModel({
    required this.uid,
    required this.email,
    this.imageUrl,
    this.createdAt,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map["uid"],
      email: map["email"],
      imageUrl: map["image_url"],
      createdAt: map["created_at"],
    );
  }

  Map<String, dynamic> toMap() {
    return {"uid": uid, "email": email, "image_url": imageUrl};
  }
}
