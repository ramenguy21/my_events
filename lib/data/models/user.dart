class UserModel {
  final int id;
  final String email;
  final String token;

  UserModel({required this.id, required this.email, required this.token});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: int.tryParse(json['id'].toString()) ?? 0,
      email: json['email'] ?? '',
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'email': email, 'token': token};
  }
}
