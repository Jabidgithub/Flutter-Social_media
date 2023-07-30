class AuthenticationResponse {
  final String info;
  final String user;

  AuthenticationResponse({required this.info, required this.user});

  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) {
    return AuthenticationResponse(
      info: json['info'],
      user: json['user'],
    );
  }
}
