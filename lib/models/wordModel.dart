import 'dart:collection';
import 'package:vocabb/consts/enums.dart';
import 'definitionModel.dart';

class WordModel{
  final String word;
  final Map<String, List<DefinitionModel>> meanings;
  LearningStatus learningStatus;
  int reviewCount;

  WordModel({
    required this.word,
    required this.meanings,
    required this.learningStatus,
    required this.reviewCount
  });

  Map<String, dynamic> toJson() {
    HashMap<String, dynamic> meaningsInJson = HashMap();

    for (String partOfSpeech in meanings.keys) {
      meaningsInJson.putIfAbsent(partOfSpeech, () => meanings[partOfSpeech]!
          .map((definitionModel) => definitionModel.toJson()).toList());
    }

    return {
      "word": word,
      "learningStatus": learningStatus.displayText,
      "meanings": meaningsInJson,
      "reviewCount": reviewCount
    };
  }

  static WordModel fromJson(Map<String, dynamic> data) {
    Map<String, dynamic> meaningsInJson = data["meanings"];
    Map<String, List<DefinitionModel>> meaningsFromJson = HashMap();

    for (String partOfSpeech in meaningsInJson.keys) {
      meaningsFromJson.putIfAbsent(partOfSpeech, () => meaningsInJson[partOfSpeech]
          .map<DefinitionModel>((definition) =>
            DefinitionModel.fromJson(definition)).toList());
    }

    LearningStatus learningStatus;
    switch(data["learningStatus"]) {
      case "NEW WORD":
        learningStatus = LearningStatus.unknown;
        break;
      case "LEARNING":
        learningStatus = LearningStatus.learning;
        break;
      case "REVIEWING":
        learningStatus = LearningStatus.reviewing;
        break;
      case "MASTERED":
        learningStatus = LearningStatus.mastered;
        break;
      default:
        learningStatus = LearningStatus.unknown;
        break;
    }

    return WordModel(
        word: data["word"],
        meanings: meaningsFromJson,
        learningStatus: learningStatus,
        reviewCount: data["reviewCount"]
    );
  }

}