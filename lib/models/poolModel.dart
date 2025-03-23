import 'package:vocabb/models/wordModel.dart';

class PoolModel {
  String name;
  String user;
  String? description;
  int rating;
  List<WordModel> words;

  PoolModel({
    required this.name,
    this.description,
    required this.user,
    required this.rating,
    required this.words
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "user": user,
      "description": description ?? "",
      "rating": rating,
      "words": words
    };
  }

}