import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class LandingViewModel {
  String? url;
  Future getBackgroundImage() async {
    try {
      await downloadBackgroundPhoto();
      return url;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }

  Future<void> downloadBackgroundPhoto() async {
    final ref = FirebaseStorage.instance.ref("cup_coffee.png");
    url = await ref.getDownloadURL();
    print(url);

    debugPrint(url.toString());
  }


}
