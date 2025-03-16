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
    HashMap<String, dynamic> wordMeaningsInJson = HashMap();
    HashMap<String, dynamic> meaningsInJson = HashMap();


    for (String partOfSpeech in meanings.keys) {
      meaningsInJson.putIfAbsent(partOfSpeech, () => []);
      for (var meaning in meanings[partOfSpeech]!) {
        HashMap<String, String> definitionsInJson = HashMap();
        definitionsInJson.putIfAbsent("defintition", () => meaning.definition);
        if (meaning.example != null) {
          definitionsInJson.putIfAbsent("example", () => meaning.example!);
        }
        meaningsInJson[partOfSpeech].add(definitionsInJson);
      }
    }

    wordMeaningsInJson.putIfAbsent(word, () => meaningsInJson);
    return wordMeaningsInJson;
  }

}