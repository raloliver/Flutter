import 'package:firebase_auth/firebase_auth.dart';
class Singleton {

  static Singleton _instance;
  factory Singleton({String uiid}) {
    _instance ??= Singleton._internalConstructor(uiid);
    return _instance;
  }
  Singleton._internalConstructor(this.uiid);

  String uiid;

  teste() {

  }

}
