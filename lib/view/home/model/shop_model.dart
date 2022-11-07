import 'package:flutter/cupertino.dart';

class ShopModel {
  final String shopName;
  final String photoUrl;
  final String distance;
  final String rating;
  final String ratingAmount;
  final String description;

  ShopModel(
      {required this.shopName,
      required this.photoUrl,
      required this.description,
      required this.distance,
      required this.rating,
      required this.ratingAmount});

  factory ShopModel.fromJson(Map<String, dynamic> json) {
    return ShopModel(
      description: json["description"],
      distance: json["distance"],
      shopName: json["shopName"],
      rating: json["rating"],
      ratingAmount: json["ratingAmount"],
      photoUrl: json["photoUrl"],
    );
  }
}
