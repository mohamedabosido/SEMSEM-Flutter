class UserModel {
  String id;
  String fName;
  String lName;
  String email;
  String phone;
  String address;

  UserModel({
    required this.id,
    required this.fName,
    required this.lName,
    required this.email,
    required this.phone,
    required this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      fName: json['fName'],
      lName: json['lName'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fName'] = fName;
    data['lName'] = lName;
    data['email'] = email;
    data['address'] = address;
    data['phone'] = phone;
    return data;
  }
}
