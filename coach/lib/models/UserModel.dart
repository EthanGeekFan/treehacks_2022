import 'package:flutter/material.dart';

enum Gender {
  male,
  female,
  other,
  notInitialized,
}

class UserModel extends ChangeNotifier {
  String name = "";
  String password = "";
  String phone = "";
  int age = 18;
  Gender gender = Gender.notInitialized;

  init() async {}
}
