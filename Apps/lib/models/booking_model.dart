class BookingModel {
  final String id;
  final String foodId;
  final String foodName;
  final String customerName;
  final String phone;
  final int quantity;

  BookingModel({
    required this.id,
    required this.foodId,
    required this.foodName,
    required this.customerName,
    required this.phone,
    required this.quantity,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    if (json['id'] == null ||
        json['foodId'] == null ||
        json['foodName'] == null ||
        json['customerName'] == null ||
        json['phone'] == null ||
        json['quantity'] == null) {
      throw FormatException('Invalid booking JSON');
    }

    if (json['quantity'] is! int || json['quantity'] <= 0) {
      throw FormatException('Invalid quantity');
    }

    return BookingModel(
      id: json['id'].toString(),
      foodId: json['foodId'].toString(),
      foodName: json['foodName'].toString(),
      customerName: json['customerName'].toString(),
      phone: json['phone'].toString(),
      quantity: json['quantity'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'foodId': foodId,
      'foodName': foodName,
      'customerName': customerName,
      'phone': phone,
      'quantity': quantity,
    };
  }
}