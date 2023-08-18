class DeleteInfo {
  final String info;

  DeleteInfo({required this.info});

  factory DeleteInfo.fromJson(Map<String, dynamic> json) {
    return DeleteInfo(
      info: json['info'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'info': info,
    };
  }
}
