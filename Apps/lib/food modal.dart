class FoodModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final int quota;

  FoodModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.quota,
  });

  factory FoodModel.fromMap(String id, Map<String, dynamic> data) {
    return FoodModel(
      id: id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      quota: data['quota'] ?? 0,
    );
  }
}