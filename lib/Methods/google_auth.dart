import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth {
  signInWithGoogle() async {
    //begin sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    //obtain sign in details
    final GoogleSignInAuthentication gAUTH = await gUser!.authentication;

    //create new credetials
    final credential = GoogleAuthProvider.credential(
      accessToken: gAUTH.accessToken,
      idToken: gAUTH.idToken,
    );

    //sign in
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
