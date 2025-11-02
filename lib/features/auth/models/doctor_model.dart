class DoctorModel {
  String? name;
  String? email;
  String? image;
  String? phone1;
  String? bio;
  String? uid;
  String? specialization;
  int? rating;
  String? phone2;
  String? openHour;
  String? closeHour;
  String? address;

  DoctorModel({this.name, this.email, this.image, this.phone1, this.bio, this.uid, this.specialization, this.rating, this.phone2, this.openHour, this.closeHour, this.address});

  factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(name: json['name'] as String?, email: json['email'] as String?, image: json['image'] as String?, phone1: json['phone1'] as String?, bio: json['bio'] as String?, uid: json['uid'] as String?, specialization: json['specialization'] as String?, rating: json['rating'] as int?, phone2: json['phone2'] as String?, openHour: json['openHour'] as String?, closeHour: json['closeHour'] as String?, address: json['address'] as String?);

  Map<String, dynamic> toJson() => {'name': name, 'email': email, 'image': image, 'phone1': phone1, 'bio': bio, 'uid': uid, 'specialization': specialization, 'rating': rating, 'phone2': phone2, 'openHour': openHour, 'closeHour': closeHour, 'address': address};
  Map<String, dynamic> updateData() => {if (name != null) 'name': name, if (email != null) 'email': email, if (image != null) 'image': image, if (phone1 != null) 'phone1': phone1, if (bio != null) 'bio': bio, if (uid != null) 'uid': uid, if (specialization != null) 'specialization': specialization, if (rating != null) 'rating': rating, if (phone2 != null) 'phone2': phone2, if (openHour != null) 'openHour': openHour, if (closeHour != null) 'closeHour': closeHour, if (address != null) 'address': address};
}
