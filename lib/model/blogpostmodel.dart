class BlogPost {
  String id;
  String title;
  String description;
  String imageUrl;
  String userId;

  BlogPost({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'userId': userId,
    };
  }

  BlogPost.fromMap(Map<String, dynamic> map, {required this.id})
      : title = map['title'],
        description = map['description'],
        imageUrl = map['imageUrl'],
        userId = map['userId'];
}
