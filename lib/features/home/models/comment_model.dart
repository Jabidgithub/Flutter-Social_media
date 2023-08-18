class Comment {
  final String body;
  final String postId;
  final String commentId;
  final DateTime createAt;
  final User user;

  Comment({
    required this.body,
    required this.postId,
    required this.commentId,
    required this.createAt,
    required this.user,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      body: json['body'],
      postId: json['postId'],
      commentId: json['commentId'],
      createAt: DateTime.parse(json['createAt']),
      user: User.fromJson(json['user']),
    );
  }
  String getFormattedCreateAt() {
    final Duration difference = DateTime.now().difference(createAt);
    if (difference.inSeconds < 60) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 30) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 365) {
      return '${difference.inDays ~/ 30} months ago';
    } else {
      return '${difference.inDays ~/ 365} years ago';
    }
  }
}

class User {
  final String id;
  final String? avatar;
  final String? name;

  User({
    required this.id,
    this.avatar,
    this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      avatar: json['avatar'],
      name: json['name'],
    );
  }
}
