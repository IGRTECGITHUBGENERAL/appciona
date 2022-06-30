import 'package:appciona/firebaseServices/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController {
  Future<bool> login(String email, String pass) async {
    AuthServices as = AuthServices();
    UserCredential? uc = await as.singIn(email, pass);
    if (uc != null) {
      return true;
    } else {
      return false;
    }
  }
}
