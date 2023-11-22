import 'package:doctor_appointment_app/sheets/fields.dart';

class UserFiels {
  static final String id = 'ID';
  static final String name = 'ชื่อ-สกุล';
  static final String email = 'อายุ';
  static final String status = 'สถานะ';
  static final String address = 'ที่อยู่';

  static List<String> getFields() => [id, name, email, status, address];

}

class User {
  final int id;
  final String name;
  final int age;
  final String status;
  final String address;

  const User ({
  required this.id,
  required this.name,
  required this.age,
  required this.status,
  required this.address,
});

  User copy({
    int? id,
    String? name,
    int? age,
    String? status,
    String? address,
  }) => 
    User(
      id: id ?? this.id,
      name: name?? this.name,
      age: age?? this.age,
      status: status?? this.status,
      address: address?? this.address,
    );

Map<String, dynamic>toJson() => {
  UserFields.id: id,
  UserFields.name: name,
  UserFields.age: age,
  UserFields.status: status,
  UserFields.address: address,
};
}