import 'package:flutter/foundation.dart';
import '../services/api_scan_service.dart';
import '../models/recommendation_product_model.dart';

class SkincarePlanViewModel extends ChangeNotifier {
  final ApiScanService _apiService = ApiScanService();

  RecommendProductModel? recommendation;
  bool isLoading = false;
  String? error;

  Future<void> fetchRecommendations() async {
    isLoading = true;
    error = null;
    notifyListeners();

    final request = RecommendationRequest(
      dateOfBirth: "1995-06-15T00:00:00.000Z",
      gender: "male",
      skinType: "normal",
      allergies: [],
      pregnant: false,
      underMedication: false,
      additionalSkinCondition: [],
      dataPolicy: "no_save",
      signature: "string",
      skinConditionTreatment: "string",
      budgetType: "high",
    );

    try {
      final response = await _apiService.getRecommendationsV2(
        userId: "64289931-30b8-43c4-983e-e36ecd880930",
        request: request,
      );

      recommendation = response;

      print("✅ Recommendation loaded");
      print(
          "📦 Total moisturizers: ${recommendation?.moisturizers.length ?? 0}");
    } catch (e) {
      error = "Failed to fetch recommendations: $e";
      print("❌ Error during API call: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
