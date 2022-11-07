import 'package:flutter/cupertino.dart';

class AmountProvider extends ChangeNotifier {
  int _amount = 100;
  int get amount => _amount;
  void amountUpdate(int amount) {
    _amount = amount;
    notifyListeners();
  }


}
