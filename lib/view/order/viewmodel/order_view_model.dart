import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cup_coffee/view/order/model/order_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class OrderViewModel {
  String? url;

  Stream<List<OrderModel>> getOrderData() {
    return FirebaseFirestore.instance.collection("order").snapshots().map(
        (order) =>
            order.docs.map((doc) => OrderModel.fromJson(doc.data())).toList());
  }

  Future getImage() async {
    try {
      await downloadImage();
      return url;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }

  Future<void> downloadImage() async {
    final ref = FirebaseStorage.instance.ref("lottie.png");
    url = await ref.getDownloadURL();
    print(url);

    debugPrint(url.toString());
  }

  Future cleanOrderList() async {
    await FirebaseFirestore.instance.collection('order').get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
  }
    Future updateData(int count) async {
    var collection = FirebaseFirestore.instance.collection('order');
    collection.doc('order').update({"itemAmount": count.toString()});
  }
}
