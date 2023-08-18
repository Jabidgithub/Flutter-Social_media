class Video {
  final String reelsId;
  final String userId;
  final String description;
  final String videoUrl;
  final String createAt;
  final String updateAt;
  final User user;

  Video({
    required this.reelsId,
    required this.userId,
    required this.description,
    required this.videoUrl,
    required this.createAt,
    required this.updateAt,
    required this.user,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      reelsId: json['reelsId'],
      userId: json['userId'],
      description: json['description'],
      videoUrl: json['video'],
      createAt: json['createAt'],
      updateAt: json['updateAt'],
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final String id;
  final String avatar;
  final String name;

  User({
    required this.id,
    required this.avatar,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      avatar: json['avatar'],
      name: json['name'],
    );
  }
}
