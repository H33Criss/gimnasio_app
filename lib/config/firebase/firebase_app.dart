import 'package:firebase_core/firebase_core.dart';
import 'package:gym_app/config/firebase/firebase_options.dart';

class FirebaseService {
  late FirebaseApp firebaseApp; //Asegúrate de que firebaseApp sea nullable

  Future<void> setFirebaseApp() async {
    //Indica que es una función con Future<void>
    firebaseApp = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
