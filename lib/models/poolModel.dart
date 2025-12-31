import 'package:flutter/widgets.dart';
import 'package:vocabb/models/wordModel.dart';
import 'package:vocabb/services/dbServices.dart';

class PoolModel with ChangeNotifier{
  String id;
  String name;
  String user;
  String? description;
  int rating;
  List<WordModel> words;
  int totalWordsCount;
  int masteredWordsCount;
  int reviewingWordsCount;
  int learningWordsCount;
  int unvisitedWordsCount;

  PoolModel({
    required this.id,
    required this.name,
    this.description,
    required this.user,
    required this.rating,
    required this.words,
    required this.totalWordsCount,
    required this.masteredWordsCount,
    required this.reviewingWordsCount,
    required this.learningWordsCount,
    required this.unvisitedWordsCount
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "user": user,
      "description": description ?? "",
      "rating": rating,
      "words": words.map((word) => word.toJson()).toList(),
      "totalWordsCount": totalWordsCount,
      "masteredWordsCount": masteredWordsCount,
      "reviewingWordsCount": reviewingWordsCount,
      "learningWordsCount": learningWordsCount,
      "unvisitedWordsCount": unvisitedWordsCount
    };
  }

  static PoolModel fromJson(String id, Map<String, dynamic> data) {
    return PoolModel(
        id: id,
        name: data["name"],
        user: data["user"],
        description: data.containsKey("description") ? data["description"] : null,
        rating: data["rating"],
        words: List<WordModel>.from(data["words"].map(
                (word) => WordModel.fromJson(word)).toList()),
        totalWordsCount: data["totalWordsCount"],
        masteredWordsCount: data["masteredWordsCount"],
        reviewingWordsCount: data["reviewingWordsCount"],
        learningWordsCount: data["learningWordsCount"],
        unvisitedWordsCount: data["unvisitedWordsCount"]
    );
  }

  void update(List<WordModel> words, int unvisitedWordsCount, int learningWordsCount, int reviewingWordsCount, int masteredWordsCount) {
    this.words = words;
    this.unvisitedWordsCount = unvisitedWordsCount;
    this.learningWordsCount = learningWordsCount;
    this.reviewingWordsCount = reviewingWordsCount;
    this.masteredWordsCount = masteredWordsCount;
  }

  static Future<PoolModel?> createNewPool(String name, String description, String? user) async {
    return await DbServices.createPool(
        name,
        user ?? "Default",
        description.isNotEmpty ? description : "No Description"
    );
  }

  Future<bool> addWordToPool(WordModel wordModel) async {
    bool res = await DbServices.addWordToPoolById(id, wordModel);
    if (res) {
      words.add(wordModel);
      totalWordsCount += 1;
      unvisitedWordsCount += 1;
    }
    return res;
  }


}