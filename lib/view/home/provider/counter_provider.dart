import 'package:flutter/cupertino.dart';

class CounterProvider extends ChangeNotifier {
  int _count = 0;
  int get count => _count;
  void increment() {
    _count = _count + 1;
    notifyListeners();
  }

  void decrement() {
    if (_count == 0) {
    } else {
      _count = _count - 1;
    }
    notifyListeners();
  }

  void cleanProvider() {
    _count = 0;
  }
}
