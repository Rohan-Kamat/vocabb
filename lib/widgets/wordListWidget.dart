
import 'package:flutter/material.dart';
import 'package:vocabb/models/definitionModel.dart';
import 'package:vocabb/models/poolModel.dart';
import 'package:vocabb/models/wordModel.dart';
import 'package:vocabb/services/dbServices.dart';
import 'package:vocabb/widgets/meaningDisplayWidget.dart';

class WordListWidget extends StatefulWidget {

  final PoolModel poolModel;

  const WordListWidget({
    required this.poolModel,
    super.key
  });

  @override
  State<WordListWidget> createState() => _WordListWidgetState();
}

class _WordListWidgetState extends State<WordListWidget> {

  late List<bool> _isSelected;
  late Stream<List<WordModel>> wordStream;
  int _previousIndex = 0;

  @override
  void initState() {
    wordStream = DbServices.getWordStreamByPoolId(widget.poolModel.id);
    _isSelected = <bool>[];
    for (int i = 0; i < widget.poolModel.words.length; i++) {
      _isSelected.add(false);
    }
  }

  void addStateForNewWord() {
    for (int i = 0; i < widget.poolModel.words.length - _isSelected.length; i++) {
      _isSelected.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<List<WordModel>>(
      stream: wordStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong. Make sure your internet connection is stable and try again", style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary.withOpacity(0.7),
              fontSize: 15
          ), textAlign: TextAlign.center,);
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(
              color: Theme.of(context).colorScheme.secondary
          );
        }

        List<WordModel> words = snapshot.data!;
        addStateForNewWord();
        print("_isSelected length: ${_isSelected.length}");
        print("Words Length: ${words.length}");
        return words.isEmpty
          ? Text("No words in this pool. Add a word by clicking on the plus icon on the bottom right corner", style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary.withOpacity(0.7),
              fontSize: 15,
            ), textAlign: TextAlign.center)
          : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: words.length,
            itemBuilder: (context, index) {
              String firstPartOfSpeech = words[index].meanings.keys.first;
              DefinitionModel firstDefinition = words[index].meanings[firstPartOfSpeech]![0];
              return Padding(
                padding: const EdgeInsets.only(top: 8.5, bottom: 8.5, left: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (_previousIndex != index) {
                            _isSelected[_previousIndex] = false;
                          }
                          _isSelected[index] = !_isSelected[index];
                          _previousIndex = index;
                        });
                      },
                      child: Text(words[index].word, style: TextStyle(
                          fontWeight: _isSelected[index] ? FontWeight.w500 : FontWeight.w300,
                          fontSize: _isSelected[index] ? 22 : 20,
                          color: _isSelected[index]
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).colorScheme.secondary
                      ),),
                    ),
                    SizedBox(height: _isSelected[index] ? 5 : 0,),
                    Visibility(
                        visible: _isSelected[index],
                        child: MeaningDisplayWidget(
                            wordModel: words[index],
                            selectable: false,
                            hasViewAllButton: true,
                            partOfSpeech: firstPartOfSpeech,
                            definition: firstDefinition.definition,
                            example: firstDefinition.example
                        )
                    )
                  ],
                ),
              );
            }
        );
      },
    );

  }
}


