import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:vocabb/consts/enums.dart';
import 'package:vocabb/models/definitionModel.dart';
import 'package:vocabb/models/wordModel.dart';

class WordMeaningsProvider with ChangeNotifier {
  WordModel? word;
  HashMap<String, List<bool>> isSelected = HashMap();
  int totalMeaningsSelected = 0;

  WordModel? get getWord => word;
  bool isMeaningSelected(String partOfSpeech, int index) {
    return isSelected[partOfSpeech]![index];
  }

  bool areAnyMeaningsSelected() {
    return totalMeaningsSelected > 0;
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
    return WordModel(
      word: word!.word,
      meanings: meanings,
      learningStatus: LearningStatus.unknown,
      reviewCount: 0
    );
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
    bool currentStatus = isSelected[partOfSpeech]![index];
    if (currentStatus) {
      totalMeaningsSelected -= 1;
    } else {
      totalMeaningsSelected += 1;
    }
    isSelected[partOfSpeech]![index] = !isSelected[partOfSpeech]![index];
    notifyListeners();
  }

  void resetState() {
    word = null;
    isSelected = HashMap();
    notifyListeners();
  }
}
