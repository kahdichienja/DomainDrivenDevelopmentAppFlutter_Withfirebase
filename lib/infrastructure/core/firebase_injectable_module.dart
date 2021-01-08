
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
@registerModule
abstract class FirebasInjectableModule {

  @lazySingleton
  GoogleSignIn get googleSignIn => GoogleSignIn();
  @lazySingleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;
  // @lazySingleton
  // FirebaseAuth get firebaseAuth => FirebaseAuth.instance;


  
}