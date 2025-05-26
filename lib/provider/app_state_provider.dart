import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  Locale _locale = Locale('vi');

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }
}
