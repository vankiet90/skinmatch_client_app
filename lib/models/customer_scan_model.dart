class CustomerScanModel {
  final String id;
  final String userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<SkinAnalysisItem> skinAnalysis;

  CustomerScanModel({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.skinAnalysis,
  });

  factory CustomerScanModel.fromJson(Map<String, dynamic> json) {
    var list = json['skin_analysis'] as List<dynamic>;
    List<SkinAnalysisItem> skinItems =
        list.map((item) => SkinAnalysisItem.fromJson(item)).toList();

    return CustomerScanModel(
      id: json['id'],
      userId: json['user_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      skinAnalysis: skinItems,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'skin_analysis': skinAnalysis.map((item) => item.toJson()).toList(),
    };
  }
}

class SkinAnalysisItem {
  final String name;
  final double value;
  final String? description;

  SkinAnalysisItem({
    required this.name,
    required this.value,
    this.description,
  });

  factory SkinAnalysisItem.fromJson(Map<String, dynamic> json) {
    return SkinAnalysisItem(
      name: json['name'],
      value: (json['value'] as num).toDouble(),
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'value': value,
      'description': description,
    };
  }
}
