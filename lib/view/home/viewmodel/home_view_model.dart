import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cup_coffee/view/home/model/coffee_model.dart';
import 'package:cup_coffee/view/home/model/shop_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class HomeViewModel {
  String? url;
  Future getProfileImage() async {
    try {
      await downloadProfilePhoto();
      return url;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }

  Future<void> downloadProfilePhoto() async {
    final ref = FirebaseStorage.instance.ref("profile_photo.png");
    url = await ref.getDownloadURL();
    print(url);

    debugPrint(url.toString());
  }

  Stream<List<CoffeeModel>> getCoffeeData() {
    return FirebaseFirestore.instance.collection("coffees").snapshots().map(
        (coffee) => coffee.docs
            .map((doc) => CoffeeModel.fromJson(doc.data()))
            .toList());
  }

  Stream<List<ShopModel>> getShopData() {
    return FirebaseFirestore.instance.collection("shops").snapshots().map(
        (shop) =>
            shop.docs.map((doc) => ShopModel.fromJson(doc.data())).toList());
  }

  Future addToCart(
      {required CoffeeModel model,
      required String coffeeAmount,
      required String itemAmount}) async {
    await FirebaseFirestore.instance.collection("order").doc("order").set({
      "itemAmount": itemAmount,
      "orderItem": model.coffeeName,
      "price": model.price,
      "coffeeAmount": coffeeAmount,
      "photoUrl": model.photoUrl,
    });
  }

  Future cleanOrderList() async {
    await FirebaseFirestore.instance.collection('order').get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
  }


}
