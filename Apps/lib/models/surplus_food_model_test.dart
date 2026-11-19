class SurplusFoodModel {
  final String id;
  final String merchantId;
  final String name;
  final String description;
  final double originalPrice;
  final double discountPrice;
  final int quota;
  final bool isActive;
  final String? imageUrl;
  final DateTime createdAt;

  const SurplusFoodModel({
    required this.id,
    required this.merchantId,
    required this.name,
    required this.description,
    required this.originalPrice,
    required this.discountPrice,
    required this.quota,
    required this.isActive,
    this.imageUrl,
    required this.createdAt,
  });

  // Mengubah JSON menjadi object model
  factory SurplusFoodModel.fromJson(Map<String, dynamic> json) {
    return SurplusFoodModel(
      id: json['id'].toString(),
      merchantId: json['merchantId'].toString(),
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      originalPrice: (json['originalPrice'] as num).toDouble(),
      discountPrice: (json['discountPrice'] as num).toDouble(),
      quota: (json['quota'] as num).toInt(),
      isActive: json['isActive'] as bool,
      imageUrl: json['imageUrl'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  // Mengubah object model menjadi JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'merchantId': merchantId,
      'name': name,
      'description': description,
      'originalPrice': originalPrice,
      'discountPrice': discountPrice,
      'quota': quota,
      'isActive': isActive,
      'imageUrl': imageUrl,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Menghitung persentase diskon
  double get discountPercentage {
    if (originalPrice <= 0) return 0;

    return ((originalPrice - discountPrice) / originalPrice) * 100;
  }

  // Memeriksa apakah makanan masih tersedia
  bool get isAvailable {
    return isActive && quota > 0;
  }

  // Membuat salinan object dengan perubahan tertentu
  SurplusFoodModel copyWith({
    String? id,
    String? merchantId,
    String? name,
    String? description,
    double? originalPrice,
    double? discountPrice,
    int? quota,
    bool? isActive,
    String? imageUrl,
    DateTime? createdAt,
  }) {
    return SurplusFoodModel(
      id: id ?? this.id,
      merchantId: merchantId ?? this.merchantId,
      name: name ?? this.name,
      description: description ?? this.description,
      originalPrice: originalPrice ?? this.originalPrice,
      discountPrice: discountPrice ?? this.discountPrice,
      quota: quota ?? this.quota,
      isActive: isActive ?? this.isActive,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
