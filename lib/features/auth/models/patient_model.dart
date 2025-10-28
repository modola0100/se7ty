class PatientModel {
  String? name;
  String? email;
  String? image;
  String? age;
  String? phone;
  int? gender;
  String? bio;
  String? city;
  String? uid;

  PatientModel({
    this.name,
    this.email,
    this.image,
    this.age,
    this.phone,
    this.gender,
    this.bio,
    this.city,
    this.uid,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) => PatientModel(
    name: json['name'] as String?,
    email: json['email'] as String?,
    image: json['image'] as String?,
    age: json['age'] as String?,
    phone: json['phone'] as String?,
    gender: json['gender'] as int?,
    bio: json['bio'] as String?,
    city: json['city'] as String?,
    uid: json['uid'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'image': image,
    'age': age,
    'phone': phone,
    'gender': gender,
    'bio': bio,
    'city': city,
    'uid': uid,
  };
}
