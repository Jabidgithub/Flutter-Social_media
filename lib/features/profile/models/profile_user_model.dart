class UserData {
  final String id;
  final String avatar;
  final String email;
  final String name;
  final String phone;
  final String location;
  final String gender;
  final Count count;

  UserData({
    required this.id,
    required this.avatar,
    required this.email,
    required this.name,
    required this.phone,
    required this.location,
    required this.gender,
    required this.count,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      avatar: json['avatar'],
      email: json['email'],
      name: json['name'],
      phone: json['phone'],
      location: json['location'],
      gender: json['gender'],
      count: Count.fromJson(json['_count']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'avatar': avatar,
      'email': email,
      'name': name,
      'phone': phone,
      'location': location,
      'gender': gender,
      '_count': count.toJson(),
    };
  }

  @override
  String toString() {
    return 'UserData{id: $id, avatar: $avatar, email: $email, name: $name, phone: $phone, location: $location, gender: $gender, count: $count}';
  }
}

class Count {
  final int followers;
  final int following;
  final int posts;
  final int reacts;

  Count({
    required this.followers,
    required this.following,
    required this.posts,
    required this.reacts,
  });

  factory Count.fromJson(Map<String, dynamic> json) {
    return Count(
      followers: json['followers'],
      following: json['following'],
      posts: json['posts'],
      reacts: json['Reacts'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'followers': followers,
      'following': following,
      'posts': posts,
      'Reacts': reacts,
    };
  }

  @override
  String toString() {
    return 'Count{followers: $followers, following: $following, posts: $posts, reacts: $reacts}';
  }
}
