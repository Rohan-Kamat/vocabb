import 'package:vocabb/models/wordModel.dart';
import 'package:vocabb/services/dbServices.dart';

class PoolModel {
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

  static PoolModel fromJson(Map<String, dynamic> data) {
    return PoolModel(
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


}