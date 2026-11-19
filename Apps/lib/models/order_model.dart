class OrderModel {
  final String id;
  final String buyerId;
  final String foodId;
  final String pickupCode;
  final String status;
  final DateTime createdAt;

  const OrderModel({
    required this.id,
    required this.buyerId,
    required this.foodId,
    required this.pickupCode,
    required this.status,
    required this.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as String,
      buyerId: json['buyerId'] as String,
      foodId: json['foodId'] as String,
      pickupCode: json['pickupCode'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'buyerId': buyerId,
      'foodId': foodId,
      'pickupCode': pickupCode,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  OrderModel copyWith({
    String? id,
    String? buyerId,
    String? foodId,
    String? pickupCode,
    String? status,
    DateTime? createdAt,
  }) {
    return OrderModel(
      id: id ?? this.id,
      buyerId: buyerId ?? this.buyerId,
      foodId: foodId ?? this.foodId,
      pickupCode: pickupCode ?? this.pickupCode,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
