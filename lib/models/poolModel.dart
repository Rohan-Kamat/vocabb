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

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "user": user,
      "description": description ?? "",
      "rating": rating,
      "words": words.map((word) => word.toJson()).toList()
    };
  }

  static PoolModel fromJson(Map<String, dynamic> data) {
    return PoolModel(
        name: data["name"],
        user: data["user"],
        description: data.containsKey("description") ? data["description"] : null,
        rating: data["rating"],
        words: List<WordModel>.from(data["words"].map(
                (word) => WordModel.fromJson(word)).toList())
    );
  }

}