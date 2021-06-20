import 'package:flutter/cupertino.dart';

class AppConstant {
  static AppConstant _instance;
  factory AppConstant() => _instance ??= new AppConstant._();
  AppConstant._();

  final String REF_KEY_STORE_LOGIN_TOKEN = "REF_KEY_STORE_LOGIN_TOKEN";
  String tokenUser = '';
  String loginedEmail = '';
  String dynamicKey = '';
  String defaultDateTimeFormat = 'dd/MM/yyyy';
  String defaultTimeFormat = 'HH:mm:ss';
  String defaultDateTimeFormat2 = 'dd/MM/yyyy HH:mm:ss.fff';

  bool validEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
  bool isTabletDevice() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 600 ? false : true;
  }
}
