import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerProvider with ChangeNotifier {
  bool _hasScanned = false;
  bool _isFirstTime = false;
  bool _isLoading = true;
  bool _showTabBar = true;
  bool _isReturningFromHistory = false; // ✅ Thêm biến này

  bool get hasScanned => _hasScanned;
  bool get isFirstTime => _isFirstTime;
  bool get isLoading => _isLoading;
  bool get showTabBar => _showTabBar;
  bool get isReturningFromHistory => _isReturningFromHistory; // ✅ Getter

  CustomerProvider() {
    _loadHasScanned();
  }

  Future<void> _loadHasScanned() async {
    await Future.delayed(Duration(milliseconds: 300));

    final prefs = await SharedPreferences.getInstance();
    _hasScanned = prefs.getBool('hasScanned') ?? false;
    _isFirstTime = prefs.getBool('isFirstTime') ?? false;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> reloadHasScanned() async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    _hasScanned = prefs.getBool('hasScanned') ?? false;
    _isFirstTime = prefs.getBool('isFirstTime') ?? false;

    _isLoading = false;
    notifyListeners();
  }

  Future<void> setHasScanned(bool value) async {
    if (_hasScanned == value) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasScanned', value);
    _hasScanned = value;
    notifyListeners();
  }

  Future<void> setIsFirstTime(bool value) async {
    if (_isFirstTime == value) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', value);
    _isFirstTime = value;
    notifyListeners();
  }

  void setShowTabBar(bool value) {
    if (_showTabBar == value) return;
    _showTabBar = value;
    notifyListeners();
  }

  void setIsReturningFromHistory(bool value) {
    if (_isReturningFromHistory == value) return;
    _isReturningFromHistory = value;
    notifyListeners();
  }

  Future<void> reset() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasScanned', false);
    await prefs.setBool('isFirstTime', false);

    _hasScanned = false;
    _isFirstTime = false;
    _showTabBar = true;
    _isReturningFromHistory = false;

    notifyListeners();
  }
}
