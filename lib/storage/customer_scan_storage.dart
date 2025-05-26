import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/customer_scan_model.dart';

class CustomerScanStorage {
  static const String _key = 'customer_scan_model';

  Future<void> saveScan(CustomerScanModel model) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(model.toJson());
    await prefs.setString(_key, jsonString);
  }

  Future<CustomerScanModel?> loadScan() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString == null) return null;

    final Map<String, dynamic> jsonData = json.decode(jsonString);
    return CustomerScanModel.fromJson(jsonData);
  }

  Future<void> clearScan() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
