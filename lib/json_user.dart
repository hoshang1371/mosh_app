import 'package:json_annotation/json_annotation.dart';

part 'json_user.g.dart';

@JsonSerializable()
class User {
  final String? email;
  final String? password;

  User({this.email, this.password});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() => 'User{email: $email, password: $password}';
  // User.fromJson(Map<String, dynamic> json)
  //     :  email = json['email'],
  //      password = json['password'];

  // Map<String, dynamic> toJson() => {
  //       'email': email,
  //       'password': password,
  //     };
}
