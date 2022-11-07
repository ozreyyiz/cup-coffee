class CoffeeModel {
  final String coffeeName;
  final String shopName;
  final String price;
  final String photoUrl;
  final String deliveryTime;
  final String score;
  final String description;

  CoffeeModel(
      {required this.coffeeName,
      required this.score,
     required this.description,
      required this.shopName,
      required this.price,
      required this.photoUrl,
      required this.deliveryTime});

  factory CoffeeModel.fromJson(Map<String, dynamic> json) {
    return CoffeeModel(
      description: json["description"],
      coffeeName: json["coffeeName"],
      shopName: json["shopName"],
      deliveryTime: json["deliveryTime"],
      photoUrl: json["photoUrl"],
      price: json["price"],
      score: json["score"],
    );
  }
}
