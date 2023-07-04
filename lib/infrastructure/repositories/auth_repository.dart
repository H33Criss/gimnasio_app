import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gym_app/infrastructure/models/user_model.dart';
import 'package:gym_app/main.dart';

class AuthRepository {
  final FirebaseAuth auth =
      FirebaseAuth.instanceFor(app: firebaseService.firebaseApp);
  final FirebaseFirestore fireStore =
      FirebaseFirestore.instanceFor(app: firebaseService.firebaseApp);
  OAuthProvider provider = OAuthProvider('microsoft.com');

  Future<String> setUserProfile(
      String uid, String rut, String carrera, String displayName) async {
    CollectionReference profiles = fireStore.collection('profiles');

    return profiles
        .doc(uid)
        .set({
          'rut': rut,
          'carrera': carrera,
          'displayName': displayName,
        }, SetOptions(merge: true))
        .then((value) => 'Perfil actualizado correctamente')
        .catchError((error) => 'Error al actualizar tu perfil');
  }

  Future<Map<String, String>?> getUserProfile(String uid) async {
    final docProfile = await fireStore
        .collection('profiles')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        return documentSnapshot.data() as Map<String, dynamic>;
      }
      return null;
    });

    if (docProfile != null) {
      return docProfile.map((key, value) => MapEntry(key, value.toString()));
    }

    return null;
  }

  Future<LoginResponseModel> loginWithMicrosoft() async {
    try {
      // provider.setScopes(['mail.read', 'calendars.read']);
      provider.setCustomParameters({
        'prompt': 'consent',
        'login_hint': 'usuario@usm.cl',
      });
      final response = await auth.signInWithProvider(provider);
      final profile = await getUserProfile(response.user!.uid);
      return LoginResponseModel(userCredential: response, profile: profile);
    } on FirebaseAuthException catch (err) {
      print('ERROR EN "loginWithMicrosoft": $err');
      return LoginResponseModel(userCredential: null, profile: null);
    }
  }

  Future<LoginResponseModel> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      final response = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final profile = await getUserProfile(response.user!.uid);
      return LoginResponseModel(userCredential: response, profile: profile);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return LoginResponseModel(userCredential: null, profile: null);
    }
  }

  Future<void> signOutUser() async {
    await auth.signOut();
  }
}
