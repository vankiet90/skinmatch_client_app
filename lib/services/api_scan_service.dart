import 'dart:io';
import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';
import '../models/customer_scan_model.dart';
import '../models/recommendation_product_model.dart';

class ApiScanService {
  final Dio _dio = Dio(
      // BaseOptions(
      //   connectTimeout: const Duration(seconds: 30), // tăng lên 30 giây
      //   receiveTimeout: const Duration(seconds: 30),
      // ),
      );

  Future<CustomerScanModel?> uploadSkinAnalysis({
    required File imageFile,
    String additionalInfo = '',
  }) async {
    print('Call API scan => API');
    // final String userId = const Uuid().v4();

    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        imageFile.path,
        filename: imageFile.path.split('/').last,
      ),
      'additional_info': additionalInfo,
    });

    try {
      final response = await _dio.post(
        'http://20.212.232.145:8000/api/skin-analysis/analyze',
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        print('✅ Response Data: $data');

        final model = CustomerScanModel.fromJson(data);
        return model;
      } else {
        print('⚠️ Unexpected status code: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Error uploading skin analysis: $e');
    }

    return null;
  }

  Future<RecommendProductModel> getRecommendationsV2({
    required String userId,
    required RecommendationRequest request,
  }) async {
    try {
      const baseUrl = 'http://20.212.232.145/:8000';
      final endpoint = '$baseUrl/api/recommendations/user/$userId';

      final response = await _dio.post(
        endpoint,
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        print('✅ Call API success ${response.data}');
        return RecommendProductModel.fromJson(response.data);
      } else {
        print('❌ Call API fail with status: ${response.statusCode}');
        throw Exception(
            'Failed to load recommendations: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('❌ DioException: ${e.message}');
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      print('❌ Unknown Exception: $e');
      throw Exception('Error: $e');
    }
  }
}
