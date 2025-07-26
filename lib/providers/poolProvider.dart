import 'package:flutter/material.dart';
import 'package:vocabb/models/poolModel.dart';
import 'package:vocabb/models/wordModel.dart';

class PoolProvider with ChangeNotifier {
  late PoolModel poolModel;

  bool addingWord = false;
  bool addWordSuccess = false;

  List<WordModel> get getWordsList => poolModel.words;
  String get getPoolName => poolModel.name;
  bool get isAddingWord => addingWord;
  bool get isAddWordSuccessful => addWordSuccess;

  void initialize(PoolModel poolModel) {
    this.poolModel = poolModel;
  }

  void setAddingWord(bool addingWord) {
    this.addingWord = addingWord;
    notifyListeners();
  }

  Future<bool> addWordToPool(WordModel wordModel) async {
    addWordSuccess = false;
    setAddingWord(true);
    addWordSuccess = await poolModel.addWordToPool(wordModel);
    setAddingWord(false);
    return addWordSuccess;
  }
}