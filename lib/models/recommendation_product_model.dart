class RecommendProductModel {
  final List<Product> cleansers;
  final List<Product> toners;
  final List<Product> serums;
  final List<Product> moisturizers;
  final List<Product> sunscreens;
  final List<Product> masks;
  final List<Product> exfoliators;
  final List<Product> eyeCreams;
  final List<Product> treatments;
  final List<Product> lipCare;
  final List<Product> mist;

  RecommendProductModel({
    required this.cleansers,
    required this.toners,
    required this.serums,
    required this.moisturizers,
    required this.sunscreens,
    required this.masks,
    required this.exfoliators,
    required this.eyeCreams,
    required this.treatments,
    required this.lipCare,
    required this.mist,
  });

  factory RecommendProductModel.fromJson(Map<String, dynamic> json) {
    List<Product> parseList(String key) {
      if (json[key] == null) return [];
      return (json[key] as List).map((e) => Product.fromJson(e)).toList();
    }

    return RecommendProductModel(
      cleansers: parseList("cleansers"),
      toners: parseList("toners"),
      serums: parseList("serums"),
      moisturizers: parseList("moisturizers"),
      sunscreens: parseList("sunscreens"),
      masks: parseList("masks"),
      exfoliators: parseList("exfoliators"),
      eyeCreams:
          parseList("eye_creams"), // Lưu ý JSON dùng "eye_creams" snake_case
      treatments: parseList("treatments"),
      lipCare: parseList("lip_care"),
      mist: parseList("mist"),
    );
  }

  List<Product> getAllProducts() {
    return [
      ...cleansers,
      ...toners,
      ...serums,
      ...moisturizers,
      ...sunscreens,
      ...masks,
      ...exfoliators,
      ...eyeCreams,
      ...treatments,
      ...lipCare,
      ...mist,
    ];
  }
}

class Product {
  final String id;
  final String name;
  final double price;
  final String currency;
  final String instructions;
  final String category;
  final String components;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String productImageUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.currency,
    required this.instructions,
    required this.category,
    required this.components,
    required this.createdAt,
    required this.updatedAt,
    required this.productImageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      currency: json['currency'],
      instructions: json['instructions'],
      category: json['category'],
      components: json['components'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      productImageUrl: json['product_image_url'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'currency': currency,
        'instructions': instructions,
        'category': category,
        'components': components,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
        'product_image_url': productImageUrl,
      };

  String get formattedPrice => '${price.toStringAsFixed(0)} $currency';

  List<String> get mainIngredients {
    final ingredients = components.split(',').map((e) => e.trim()).toList();
    return ingredients.take(3).toList();
  }
}

class RecommendationRequest {
  final String dateOfBirth;
  final String gender;
  final String skinType;
  final List<String> allergies;
  final bool pregnant;
  final bool underMedication;
  final List<String> additionalSkinCondition;
  final String dataPolicy;
  final String signature;
  final String skinConditionTreatment;
  final String budgetType;

  RecommendationRequest({
    required this.dateOfBirth,
    required this.gender,
    required this.skinType,
    required this.allergies,
    required this.pregnant,
    required this.underMedication,
    required this.additionalSkinCondition,
    required this.dataPolicy,
    required this.signature,
    required this.skinConditionTreatment,
    required this.budgetType,
  });

  Map<String, dynamic> toJson() => {
        'date_of_birth': dateOfBirth,
        'gender': gender,
        'skin_type': skinType,
        'allergies': allergies,
        'pregnant': pregnant,
        'under_medication': underMedication,
        'additional_skin_condition': additionalSkinCondition,
        'data_policy': dataPolicy,
        'signature': signature,
        'skin_condition_treatment': skinConditionTreatment,
        'budget_type': budgetType,
      };
}
