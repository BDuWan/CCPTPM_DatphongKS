import 'package:booking_hotel/fire_base/fire_base_auth.dart';

class AuthBloc {
  final _fireAuth = FireAuth();

  void Register(String email, String pass, String name, String phone,
      Function onSuccess, Function(String) onRegisterErr) {
    _fireAuth.Register(email, pass, name, phone, onSuccess, onRegisterErr);
  }

  void SignIn(String email, String pass, Function(String) onSuccess,
      Function(String) onSignInErr) {
    _fireAuth.SignIn(email, pass, onSuccess, onSignInErr);
  }

}
