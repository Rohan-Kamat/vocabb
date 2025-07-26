import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vocabb/consts/enums.dart';
import 'package:vocabb/models/poolModel.dart';
import 'package:vocabb/models/wordModel.dart';
import 'package:vocabb/services/dbServices.dart';

class LearningPoolProvider with ChangeNotifier {
  late List<WordModel> wordRoster;
  late PoolModel poolModel;
  late WordModel currentWord;
  Map<LearningStatus, int> statusWiseCount = {};

  static const LEARNING_STATUS_JUMP_PERCENTAGE = 0.15;
  static const REVIEWING_STATUS_JUMP_PERCENTAGE = 0.75;
  static const WORD_REVIEW_COUNT_LIMIT = 4;

  bool savingStatus = false;
  bool savedToBb = false;

  bool get isSaving => savingStatus;
  WordModel get getNextWord => currentWord;

  void setSavingStatus(bool isSaving) {
    savingStatus = isSaving;
    notifyListeners();
  }

  void initialize(PoolModel poolModel) {
    this.poolModel = poolModel;
    statusWiseCount.putIfAbsent(LearningStatus.unknown, () => poolModel.unvisitedWordsCount);
    statusWiseCount.putIfAbsent(LearningStatus.learning, () => poolModel.learningWordsCount);
    statusWiseCount.putIfAbsent(LearningStatus.reviewing, () => poolModel.reviewingWordsCount);
    statusWiseCount.putIfAbsent(LearningStatus.mastered, () => poolModel.masteredWordsCount);

    wordRoster = poolModel.words;
    currentWord = wordRoster.last;
  }

  int getJumpDistanceForLearningStatus(LearningStatus learningStatus) {
    int totalWordCount = wordRoster.length;
    Random random = Random();
    switch(learningStatus) {
      case LearningStatus.learning:
        return random.nextInt((totalWordCount*LEARNING_STATUS_JUMP_PERCENTAGE).toInt() + 1);
      case LearningStatus.reviewing:
        return random.nextInt((totalWordCount*(REVIEWING_STATUS_JUMP_PERCENTAGE - LEARNING_STATUS_JUMP_PERCENTAGE)).toInt() + 1);
      case LearningStatus.mastered:
        return random.nextInt((totalWordCount*(1 - REVIEWING_STATUS_JUMP_PERCENTAGE)).toInt() + 1);
      default:
        return 0;
    }
  }

  int getJumpIndexByLearningStatus(LearningStatus learningStatus) {
    int totalWordCount = wordRoster.length;
    int jumpIndex = 0;
    switch(learningStatus) {
      case LearningStatus.learning:
        jumpIndex = totalWordCount - 2 - getJumpDistanceForLearningStatus(learningStatus);
        break;
      case LearningStatus.reviewing:
        jumpIndex = totalWordCount - 2 - getJumpDistanceForLearningStatus(LearningStatus.learning)
                      - getJumpDistanceForLearningStatus(learningStatus);
        break;
      case LearningStatus.mastered:
        jumpIndex = totalWordCount - 2 - getJumpDistanceForLearningStatus(LearningStatus.learning)
                      - getJumpDistanceForLearningStatus(LearningStatus.reviewing)
                      - getJumpDistanceForLearningStatus(learningStatus);
        break;
      default:
        jumpIndex = totalWordCount - 1;
        break;
    }
    return max(jumpIndex, 0);
  }

  void updateRoster(int jumpIndex) {
    wordRoster.removeLast();
    wordRoster.insert(jumpIndex, currentWord);
  }

  LearningStatus getNewLearningStatus(bool testSuccess) {
    statusWiseCount[currentWord.learningStatus] = statusWiseCount[currentWord.learningStatus]! - 1;
    if (!testSuccess) {
      statusWiseCount[LearningStatus.learning] = statusWiseCount[LearningStatus.learning]! + 1;
      return LearningStatus.learning;
    } else {
      switch(currentWord.learningStatus) {
        case LearningStatus.unknown:
          statusWiseCount[LearningStatus.mastered] = statusWiseCount[LearningStatus.mastered]! + 1;
          return LearningStatus.mastered;
        case LearningStatus.learning:
          statusWiseCount[LearningStatus.reviewing] = statusWiseCount[LearningStatus.reviewing]! + 1;
          return LearningStatus.reviewing;
        case LearningStatus.reviewing:
          currentWord.reviewCount += 1;
          if (currentWord.reviewCount >= WORD_REVIEW_COUNT_LIMIT) {
            statusWiseCount[LearningStatus.mastered] = statusWiseCount[LearningStatus.mastered]! + 1;
            return LearningStatus.mastered;
          } else {
            statusWiseCount[LearningStatus.reviewing] = statusWiseCount[LearningStatus.reviewing]! + 1;
            return LearningStatus.reviewing;
          }
        case LearningStatus.mastered:
          statusWiseCount[LearningStatus.mastered] = statusWiseCount[LearningStatus.mastered]! + 1;
          return LearningStatus.mastered;
      }
    }

  }

  void updateWord(bool testSuccess) {
    currentWord.learningStatus = getNewLearningStatus(testSuccess);
    updateRoster(getJumpIndexByLearningStatus(currentWord.learningStatus));
    currentWord = wordRoster.last;
    notifyListeners();
  }

  void savePoolStatus() async{
    setSavingStatus(true);
    poolModel.update(
        wordRoster,
        statusWiseCount[LearningStatus.unknown]!,
        statusWiseCount[LearningStatus.learning]!,
        statusWiseCount[LearningStatus.reviewing]!,
        statusWiseCount[LearningStatus.mastered]!
    );
    bool res = await DbServices.updatePool(poolModel);
    savedToBb = res;
    setSavingStatus(false);
  }






}