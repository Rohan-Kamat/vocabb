import 'package:flutter/material.dart';
import 'package:vocabb/models/wordModel.dart';

enum NewWordState{addingWord, selectingMeanings}

class AddWordProvider with ChangeNotifier {
  NewWordState _newWordState = NewWordState.addingWord;

  NewWordState get getNewWordState => _newWordState;

  void setNewWordState(NewWordState newWordState) {
    print("Adding word");
    _newWordState = newWordState;
    notifyListeners();
  }
}