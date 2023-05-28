import 'package:booking_hotel/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import '../repository/user_repository.dart';

class FireAuth {
  late final FirebaseAuth firebaseAuth= FirebaseAuth.instance;
  DatabaseReference? dbRef = FirebaseDatabase.instance.ref().child('userinfo');

  void Register(String email, String pass, String name, String phone,
      Function onSuccess, Function(String) onRegisterErr) {
    Get.put(UserRepository());
    final UserRepository userRepository = UserRepository.instance;
    UserModel userModel = UserModel(email: email, name: name, phone: phone);
    firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((user) {
      userRepository.createUser(user.user!.uid, userModel, onSuccess);
    }).catchError((err) {
      _onSignUpErr(err.code, onRegisterErr);
    });
  }

  _onSignUpErr(String code, Function(String) onRegisterErr) {
    switch (code) {
      case "email-already-in-use":
        onRegisterErr("Email này đã được sử dụng");
        break;
      case "invalid-email":
        onRegisterErr("Email không hợp lệ");
        break;
      case "weak-password":
        onRegisterErr("Mật khẩu của bạn quá yếu");
        break;
      default:
        onRegisterErr("Đăng kí thất bại, vui lòng thử lại");
    }
  }

  void SignIn(String email, String pass, Function(String) onSuccess,
      Function(String) onLoginErr) {
    firebaseAuth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((user) {
      String? curUID = user.user?.uid;
      onSuccess(curUID!);
    }).catchError((err) {
      onLoginErr("Đăng nhập thất bại, sai tên tài khoản hoặc mật khẩu");
    });
  }

  Future<String> getPropertyById(String id, String property) async {
    DatabaseReference ref = FirebaseDatabase.instance
        .ref()
        .child('userinfo')
        .child(id)
        .child(property);
    DatabaseEvent event = await ref.once();
    return event.snapshot.value as String;
  }
}
