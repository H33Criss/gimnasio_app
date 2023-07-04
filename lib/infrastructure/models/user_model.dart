import 'package:firebase_auth/firebase_auth.dart';

class LoginResponseModel {
  final UserCredential? userCredential;
  final Map<String, String>? profile;

  LoginResponseModel({
    required this.userCredential,
    required this.profile,
  });
}

class UserModel {
  String uid;
  String email;
  String phone;
  String displayName;
  String? rut;
  String? carrera;

  UserModel({
    required this.uid,
    required this.email,
    required this.phone,
    required this.displayName,
    required this.carrera,
    required this.rut,
  });

  factory UserModel.fromFirestore(User user, Map<String, String>? profile) {
    return UserModel(
      uid: user.uid,
      email: user.email!,
      phone: user.phoneNumber ?? 'No definido',
      displayName: user.displayName ?? 'Usuario Administrador',
      rut: profile?['rut'],
      carrera: profile?['carrera'],
    );
  }

  void setProfileUser(String rut, String carrera) {
    this.rut = rut;
    this.carrera = carrera;
  }

  bool userHaveRequirements() {
    return rut != null && carrera != null;
  }
}
