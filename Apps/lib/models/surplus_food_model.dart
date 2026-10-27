class SurplusFoodModel {
  final String id;
  final String merchantId;
  final String name;
  final String description;
  final double originalPrice;
  final double discountPrice;
  final int quota;
  final String imageUrl;
  final String address;
  final bool isActive;
  final DateTime createdAt;

  const SurplusFoodModel({
    required this.id,
    required this.merchantId,
    required this.name,
    required this.description,
    required this.originalPrice,
    required this.discountPrice,
    required this.quota,
    required this.imageUrl,
    required this.address,
    required this.isActive,
    required this.createdAt,
  });

  /// JSON → Model
  factory SurplusFoodModel.fromJson(Map<String, dynamic> json) {
    if (json['id'] == null ||
        json['merchantId'] == null ||
        json['name'] == null ||
        json['originalPrice'] == null ||
        json['discountPrice'] == null ||
        json['quota'] == null) {
      throw const FormatException(
        'Data Surplus Food tidak lengkap',
      );
    }

    final quota = json['quota'];

    if (quota is! num || quota < 0) {
      throw const FormatException(
        'Quota Surplus Food tidak valid',
      );
    }

    return SurplusFoodModel(
      id: json['id'].toString(),
      merchantId: json['merchantId'].toString(),
      name: json['name'].toString(),
      description: json['description']?.toString() ?? '',
      originalPrice: _toDouble(json['originalPrice']),
      discountPrice: _toDouble(json['discountPrice']),
      quota: quota.toInt(),
      imageUrl: json['imageUrl']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      isActive: json['isActive'] ?? true,
      createdAt: _parseDate(json['createdAt']),
    );
  }

  /// Model → JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'merchantId': merchantId,
      'name': name,
      'description': description,
      'originalPrice': originalPrice,
      'discountPrice': discountPrice,
      'quota': quota,
      'imageUrl': imageUrl,
      'address': address,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  static double _toDouble(dynamic value) {
    if (value is num) {
      return value.toDouble();
    }

    final parsed = double.tryParse(value.toString());

    if (parsed == null) {
      throw const FormatException(
        'Harga Surplus Food tidak valid',
      );
    }

    return parsed;
  }

  static DateTime _parseDate(dynamic value) {
    if (value == null) {
      return DateTime.now();
    }

    final date = DateTime.tryParse(value.toString());

    if (date == null) {
      throw const FormatException(
        'Tanggal tidak valid',
      );
    }

    return date;
  }
}

test('SurplusFoodModel invalid', () {
  expect(
    () => SurplusFoodModel.fromJson({
      'id': 'SF001',
      'merchantId': 'M001',
      'name': 'Nasi Ayam',
      'originalPrice': 30000,
      'discountPrice': 15000,
      'quota': -1,
    }),
    throwsFormatException,
  );
});
