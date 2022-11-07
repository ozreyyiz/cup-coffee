import 'package:cloud_firestore/cloud_firestore.dart';

import '../../home/model/coffee_model.dart';

class ShopsViewModel {
  Stream<List<CoffeeModel>> getCoffeeData() {
    return FirebaseFirestore.instance.collection("coffees").snapshots().map(
        (coffee) => coffee.docs
            .map((doc) => CoffeeModel.fromJson(doc.data()))
            .toList());
  }
}
