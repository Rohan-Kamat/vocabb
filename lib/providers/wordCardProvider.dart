import 'package:flutter/material.dart';

class WordCardProvider with ChangeNotifier {
  bool _isRevealed = false;

  bool get isRevealed => _isRevealed;

  void setIsRevealed(bool isRevealed) {
    _isRevealed = isRevealed;
    notifyListeners();
  }
}