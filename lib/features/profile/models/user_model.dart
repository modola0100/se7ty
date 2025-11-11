import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final String city;
  final String? bio;
  final String? image;
  final int? age;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.city,
    this.bio,
    this.image,
    this.age,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
      city: data['city'] ?? '',
      bio: data['bio'] ?? '',
      image: data['image'] ?? '',
      age: data['age'] as int?,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'city': city,
      'bio': bio,
      'image': image,
      'age': age,
    };
  }
}
