import 'package:flutter/material.dart';
import 'package:vocabb/models/poolModel.dart';
import 'package:vocabb/models/wordModel.dart';

class PoolProvider with ChangeNotifier {
  late PoolModel poolModel;

  bool updatingWord = false;

  PoolModel get getPoolModel => poolModel;
  bool get isUpdatingWord => updatingWord;
  bool get isPoolEmpty => poolModel.words.isEmpty;

  void initialize(PoolModel poolModel) {
    this.poolModel = poolModel;
  }

  void setAddingWord(bool addingWord) {
    updatingWord = addingWord;
    notifyListeners();
  }

  void setUpdatingWord(bool updatingWord) {
    this.updatingWord = updatingWord;
    notifyListeners();
  }

  Future<bool> addWordToPool(WordModel wordModel) async {
    var updateWordSuccess = false;
    setAddingWord(true);
    updateWordSuccess = await poolModel.addWordToPool(wordModel);
    setAddingWord(false);
    return updateWordSuccess;
  }

  Future<bool> deleteWordFromPool(WordModel wordModel) async {
    var updateWordSuccess = false;
    updateWordSuccess = await poolModel.deleteWordFromPool(wordModel);
    print("Provider: Wordlist len: ${poolModel.words.length}");
    notifyListeners();
    return updateWordSuccess;
  }
}