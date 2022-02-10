import 'package:famfam/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //sign in email, password
  Future signin() async {
    _auth
        .signInWithEmailAndPassword(
            email: "title13260@gmail.com", password: "123456")
        .then((user) {
      print("signed in");
    }).catchError((error) {
      print(error);
    });
  }

  //register with email, password

  //signout
}
