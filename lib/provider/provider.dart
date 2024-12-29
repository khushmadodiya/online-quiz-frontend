import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  dynamic firstSnapshot;


  void updateFirstSnapshot(dynamic newSnapshot) {
    firstSnapshot = newSnapshot;
    notifyListeners();
  }

}
