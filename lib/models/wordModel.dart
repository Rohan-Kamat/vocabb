import 'dart:collection';

import 'definitionModel.dart';

class WordModel{
  final String word;
  final Map<String, List<DefinitionModel>> meanings;

  WordModel({
    required this.word,
    required this.meanings
  });

  Map<String, dynamic> toJson() {
    HashMap<String, dynamic> meaningsInJson = HashMap();

    for (String partOfSpeech in meanings.keys) {
      meaningsInJson.putIfAbsent(partOfSpeech, () => meanings[partOfSpeech]!
          .map((definitionModel) => definitionModel.toJson()).toList());
    }

    return {
      "word": word,
      "meanings": meaningsInJson
    };
  }

  static WordModel fromJson(Map<String, dynamic> data) {
    Map<String, dynamic> meaningsInJson = data["meanings"];
    Map<String, List<DefinitionModel>> meaningsFromJson = HashMap();

    for (String partOfSpeech in meaningsInJson.keys) {
      meaningsFromJson.putIfAbsent(partOfSpeech, () => meaningsInJson[partOfSpeech]
          .map((definition) => DefinitionModel.fromJson(definition)).toList());
    }

    return WordModel(
        word: data["word"],
        meanings: meaningsFromJson
    );
  }

}