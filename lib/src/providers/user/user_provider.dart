import 'package:flutter/foundation.dart';
import 'package:gym_app/infrastructure/models/user_model.dart';
import 'package:gym_app/infrastructure/repositories/auth_repository.dart';

enum AuthStatus {
  authenticated,
  authenticating,
  notAuthenticated,
}

enum UiStatus {
  loading,
  finished,
}

class UserProvider extends ChangeNotifier {
  UserModel? user;
  List<String> errors = [];
  final AuthRepository authRepository = AuthRepository();
  UiStatus uiStatus = UiStatus.finished;

  // ⬇ Esto no aplica para los demas provider, solo factible en este ⬇
  ValueNotifier<AuthStatus> status =
      ValueNotifier<AuthStatus>(AuthStatus.notAuthenticated);
  static final UserProvider _singleton = UserProvider._internal();
  factory UserProvider() {
    return _singleton;
  }
  UserProvider._internal();
  // ⬆ Esto no aplica para los demas provider, solo factible en este ⬆

  Future<void> setUserProfile(String rut, String carrera) async {
    uiStatus = UiStatus.loading;
    notifyListeners();
    final response = await authRepository.setUserProfile(
        user!.uid, rut, carrera, user!.displayName);
    print(response);
    if (user != null) {
      user?.setProfileUser(rut, carrera);
    }
    uiStatus = UiStatus.finished;
    notifyListeners();
  }

  Future<void> loginWithMicrosoft() async {
    status.value = AuthStatus.authenticating;
    notifyListeners();

    final response = await authRepository.loginWithMicrosoft();
    if (response.userCredential != null &&
        response.userCredential?.user != null) {
      user = UserModel.fromFirestore(
          response.userCredential!.user!, response.profile);
      status.value = AuthStatus.authenticated;
      errors.clear();
    } else {
      if (!errors.contains('Ocurrio un error, intenta de nuevo.')) {
        errors.add('Ocurrio un error, intenta de nuevo.');
      }
      status.value = AuthStatus.notAuthenticated;
    }
    notifyListeners();
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    status.value = AuthStatus.authenticating;
    notifyListeners();

    final response =
        await authRepository.loginWithEmailAndPassword(email, password);
    if (response.userCredential != null &&
        response.userCredential?.user != null) {
      user = UserModel.fromFirestore(
          response.userCredential!.user!, response.profile);
      status.value = AuthStatus.authenticated;
      errors.clear();
    } else {
      if (!errors.contains('Credenciales incorrectas')) {
        errors.add('Credenciales incorrectas');
      }
      status.value = AuthStatus.notAuthenticated;
    }
    notifyListeners();
  }

  Future<void> signOutUser() async {
    await authRepository.signOutUser();
    status.value = AuthStatus.notAuthenticated;
    notifyListeners();
  }
}
