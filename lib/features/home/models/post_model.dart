import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class PostModel extends Equatable {
  final String postId;
  final String userId;
  final String title;
  final String description;
  final List<String> pictures;
  final DateTime createAt;
  final DateTime updateAt;
  final UserModel user;
  final List<ReactionModel> reacts;
  final Map<String, int> count;

  PostModel({
    required this.postId,
    required this.userId,
    required this.title,
    required this.description,
    required this.pictures,
    required this.createAt,
    required this.updateAt,
    required this.user,
    required this.reacts,
    required this.count,
  });

  // Function to format createAt field
  String getFormattedCreatedAt() {
    return formatRelativeTime(createAt);
  }

  // Function to format updateAt field
  String getFormattedUpdatedAt() {
    return formatRelativeTime(updateAt);
  }

  // Date formatting method (same as before)
  String formatRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays >= 365) {
      return DateFormat('MMM d, y')
          .format(dateTime); // Format to "MMM d, y" (e.g., "Jul 31, 2023")
    } else if (difference.inDays >= 30) {
      final months = (difference.inDays / 30).round();
      return '$months ${months == 1 ? 'month' : 'months'} ago'; // e.g., "2 months ago"
    } else if (difference.inDays >= 1) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago'; // e.g., "3 days ago"
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago'; // e.g., "5 hours ago"
    } else {
      return 'Just now';
    }
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      postId: json['postId'],
      userId: json['userId'],
      title: json['title'],
      description: json['description'],
      pictures: List<String>.from(json['pictures']),
      createAt: DateTime.parse(json['createAt']),
      updateAt: DateTime.parse(json['updateAt']),
      user: UserModel.fromJson(json['user']),
      reacts: List<ReactionModel>.from(
          json['Reacts'].map((react) => ReactionModel.fromJson(react))),
      count: Map<String, int>.from(json['_count']),
    );
  }

  @override
  List<Object?> get props => [
        postId,
        userId,
        title,
        description,
        pictures,
        createAt,
        updateAt,
        user,
        reacts,
        count,
      ];
}

class UserModel extends Equatable {
  final String avatar;
  final String name;

  UserModel({
    required this.avatar,
    required this.name,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      avatar: json['avatar'],
      name: json['name'],
    );
  }

  @override
  List<Object?> get props => [avatar, name];
}

class ReactionModel extends Equatable {
  final String type;

  ReactionModel({
    required this.type,
  });

  factory ReactionModel.fromJson(Map<String, dynamic> json) {
    return ReactionModel(
      type: json['type'],
    );
  }

  @override
  List<Object?> get props => [type];
}
