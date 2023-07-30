class UserData {
  final String id;
  final String avatar;
  final String email;
  final String name;
  final String phone;
  final String location;
  final String gender;

  UserData({
    required this.id,
    required this.avatar,
    required this.email,
    required this.name,
    required this.phone,
    required this.location,
    required this.gender,
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
    };
  }

  @override
  String toString() {
    return 'UserData{id: $id, avatar: $avatar, email: $email, name: $name, phone: $phone, location: $location, gender: $gender}';
  }
}
