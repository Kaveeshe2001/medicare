import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicare/utils/constants/enums.dart';

class UserModel {
  final String id;
  String name;
  final String email;
  String phoneNumber;
  String profilePicture;
  AppRole role;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.phoneNumber,
      required this.profilePicture,
      required this.role,
      this.createdAt,
      this.updatedAt});

  static UserModel empty() => UserModel(
      id: '',
      name: '',
      email: '',
      phoneNumber: '',
      profilePicture: '',
      role: AppRole.patient);

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'Profile Picture': profilePicture,
      'Role': role.name,
      'CreatedAt': createdAt,
      'UpdatedAt': updatedAt = DateTime.now()
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      return UserModel(
          id: document.id,
          name: data.containsKey('Name') ? data['Name'] ?? '' : '',
          email: data.containsKey('Email') ? data['Email'] ?? '' : '',
          phoneNumber:
              data.containsKey('PhoneNumber') ? data['PhoneNumber'] ?? '' : '',
          profilePicture: data.containsKey('Profile Picture')
              ? data['Profile Picture'] ?? ''
              : '',
          role: AppRole.values.firstWhere((e) => e.name == data['Role'],
              orElse: () => AppRole.patient),
          createdAt: data.containsKey('CreatedAt')
              ? data['CreatedAt']?.toDate() ?? DateTime.now()
              : DateTime.now(),
          updatedAt: data.containsKey('UpdatedAt')
              ? data['UpdatedAt']?.toDate() ?? DateTime.now()
              : DateTime.now());
    } else {
      return empty();
    }
  }
}
