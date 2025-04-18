import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:vocabb/models/definitionModel.dart';
import 'package:vocabb/models/wordModel.dart';

class WordMeaningsProvider with ChangeNotifier {
  WordModel? word;
  HashMap<String, List<bool>> isSelected = HashMap();

  WordModel? get getWord => word;
  bool isMeaningSelected(String partOfSpeech, int index) {
    return isSelected[partOfSpeech]![index];
  }
  WordModel getSelectedMeanings() {
    HashMap<String, List<DefinitionModel>> meanings = HashMap();
    for (String partOfSpeech in isSelected.keys) {
      meanings.putIfAbsent(partOfSpeech, () => []);
      for (int i = 0; i < isSelected[partOfSpeech]!.length; i++) {
        if (isSelected[partOfSpeech]![i]) {
          meanings[partOfSpeech]!.add(DefinitionModel(
              definition: word!.meanings[partOfSpeech]![i].definition,
              example: word!.meanings[partOfSpeech]![i].example
          ));
        }
      }
    }
    return WordModel(word: word!.word, meanings: meanings);
  }

  void setWord(WordModel word) {
    this.word = word;
    for(String partOfSpeech in word.meanings.keys) {
      isSelected.putIfAbsent(partOfSpeech, () => []);
      for(int i = 0; i < word.meanings[partOfSpeech]!.length; i++) {
        isSelected[partOfSpeech]!.add(false);
      }
    }
    notifyListeners();
  }

  void toggleMeaning(String partOfSpeech, int index) {
    isSelected[partOfSpeech]![index] = !isSelected[partOfSpeech]![index];
    notifyListeners();
  }

  void resetState() {
    word = null;
    isSelected = HashMap();
    notifyListeners();
  }
}
