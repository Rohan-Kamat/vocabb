import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vocabb/models/definitionModel.dart';
import 'package:vocabb/models/wordModel.dart';

class ApiServices {

  static final Dio dio = Dio();

  static Future<WordModel?> getWordMeanings(String word) async {
    print("Fetching dictionary meaning of $word");
    try {
      Response response = await dio.get("https://api.dictionaryapi.dev/api/v2/entries/en/$word");
      List<dynamic> data = response.data;
      Map<String, List<DefinitionModel>> meanings= {};
      for (var item in data) {
        for (var meaning in item['meanings']) {
          List<DefinitionModel> definitions = [];
          for (var definitionItem in meaning['definitions']) {
            print(definitionItem['example']);
            DefinitionModel definitionInstance = DefinitionModel(
                definition: definitionItem['definition'],
                example: definitionItem['example']
            );
            definitions.add(definitionInstance);
          }
          if (meanings.containsKey(meaning['partOfSpeech'])) {
            meanings['partOfSpeech']?.addAll(definitions);
          } else {
            meanings.putIfAbsent(meaning['partOfSpeech'], () => definitions);
          }
        }
      }
      WordModel wordMeanings = WordModel(word: word, meanings: meanings);
      return wordMeanings;
    } catch(e) {
      print("Error while calling dictionary API.");
    }


  }
}