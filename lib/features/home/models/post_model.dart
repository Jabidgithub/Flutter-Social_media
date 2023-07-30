class Post {
  final String postId;
  final String userId;
  final String title;
  final String description;
  final List<String> pictures;
  final List<String> videos;
  final List<String> reacts;
  final DateTime createAt;
  final DateTime updateAt;

  Post({
    required this.postId,
    required this.userId,
    required this.title,
    required this.description,
    required this.pictures,
    required this.videos,
    required this.reacts,
    required this.createAt,
    required this.updateAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      postId: json['postId'] as String,
      userId: json['userId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      pictures: List<String>.from(json['pictures'] as List),
      videos: List<String>.from(json['videos'] as List),
      reacts: List<String>.from(json['Reacts'] as List),
      createAt: DateTime.parse(json['createAt'] as String),
      updateAt: DateTime.parse(json['updateAt'] as String),
    );
  }
}
