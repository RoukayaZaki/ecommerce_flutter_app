import 'package:design_by_contract/annotation.dart';
part 'user_model.g.dart';

@Contract()
class UserModel {
  final String uid;
  final String email;
  final String? name;
  final DateTime? birthDate;

  @Precondition({
    'uid.isNotEmpty': 'UID must not be empty',
    'email.isNotEmpty': 'Email must not be empty',
  })
  UserModel({required this.uid, required this.email, this.name, this.birthDate});

  factory UserModel.fromMap(Map<String, dynamic> map, String uid) {
    return UserModel(
      uid: uid,
      email: map['email'],
      name: map['name'],
      birthDate: map['birthDate'] != null && map['birthDate'].isNotEmpty
          ? DateTime.parse(map['birthDate'])
          : null,
    );
  }
  @Postcondition({
    'result["email"].isNotEmpty': 'Serialized email must not be empty',
  })
  Map<String, dynamic> _toMap() {
    return {
      'email': email,
      'name': name ?? '',
      'birthDate': birthDate?.toIso8601String() ?? '',
    };
  }
}