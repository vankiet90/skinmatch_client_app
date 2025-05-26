import 'package:flutter/material.dart';
import '../models/customer_scan_model.dart';
import '../storage/customer_scan_storage.dart';

class ScanHistoryViewModel extends ChangeNotifier {
  bool _isLoading = true;
  CustomerScanModel? _scanModel;

  bool get isLoading => _isLoading;
  CustomerScanModel? get scanModel => _scanModel;

  Future<void> loadScanData() async {
    _isLoading = true;
    _scanModel = null; // Reset dữ liệu cũ
    notifyListeners(); // Thông báo loading bắt đầu

    final loadedModel = await CustomerScanStorage().loadScan();

    await Future.delayed(const Duration(milliseconds: 1500)); // Delay nhân tạo

    _scanModel = loadedModel;
    _isLoading = false;
    notifyListeners(); // Thông báo loading kết thúc

    if (loadedModel != null) {
      for (var item in loadedModel.skinAnalysis) {
        debugPrint('${item.name}: ${item.value}');
      }
    } else {
      debugPrint('❌ Không có dữ liệu scan lưu local');
    }
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
