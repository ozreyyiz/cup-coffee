class OrderModel {
  final String orderItem;
  final String price;
  final String coffeeAmount;
  final String photoUrl;
  final String itemAmount;

  OrderModel(
      {required this.orderItem,
      required this.itemAmount,
      required this.price,
      required this.coffeeAmount,
      required this.photoUrl});

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      itemAmount: json["itemAmount"],
      photoUrl: json["photoUrl"],
      coffeeAmount: json["coffeeAmount"],
      orderItem: json["orderItem"],
      price: json["price"],
    );
  }
}



  // "orderItem": orderItem,
  //     "price": price,
  //     "coffeeAmount": coffeeAmount,
  //     "photoUrl": photoUrl,