


import 'package:appciona/firebaseServices/auth_services.dart';

import '../../widgets/alerts.dart';

class DeleteController {
  Future<bool> login(String email, String pass) async {
    bool result = false;
    AuthServices as = AuthServices();
    await as.singIn(email, pass).then((uc) {
      if (uc != null) {
        Delete(email,pass);
        result = true;
      } else {
        result = false;
      }
    });
    return result;
  }


  Future<bool> Delete(String email, String pass) async {
    bool result = false;
    AuthServices as = AuthServices();
    await as.deleteUser(email, pass).then((uc) {
      if (uc != null) {

        result = true;

      } else {
        result = false;
      }
    });

    return result;

  }

}
