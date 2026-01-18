import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabb/models/wordModel.dart';
import 'package:vocabb/providers/learningPoolProvider.dart';
import 'package:vocabb/widgets/LearningStatusBoxWidget.dart';
import 'package:vocabb/widgets/WordCardButtonWidget.dart';
import 'package:vocabb/widgets/meaningDisplayWidget.dart';

import '../consts/consts.dart';

class WordCardWidget extends StatefulWidget {

  final WordModel wordModel;

  const WordCardWidget({
    super.key,
    required this.wordModel
  });

  @override
  State<WordCardWidget> createState() => _WordCardWidgetState();
}

class _WordCardWidgetState extends State<WordCardWidget> {

  bool _isRevealed = false;

  @override
  Widget build(BuildContext context) {
    LearningPoolProvider learningPoolProvider = Provider.of<LearningPoolProvider>(context);
    String partOfSpeech = widget.wordModel.meanings.keys.first;
    Size size = MediaQuery.of(context).size;
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4)
      ),
      child: Container(
        height: _isRevealed ? null : size.height*0.23,
        width: 356,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4)
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  LearningStatusBoxWidget(learningStatus: widget.wordModel.learningStatus)
                ],
              ),
            ),
            _isRevealed
              ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.wordModel.word, style: const TextStyle(
                        fontSize: 15
                    )),
                    const SizedBox(height: 12,),
                    MeaningDisplayWidget(
                      partOfSpeech: partOfSpeech,
                      definition: widget.wordModel.meanings[partOfSpeech]![0].definition,
                      example: widget.wordModel.meanings[partOfSpeech]![0].example,
                      selectable: false,
                      hasOptions: true,
                      wordModel: widget.wordModel,
                    )
                  ],
                ),
              )
              : Expanded(
                child: Center(
                  child: Text(widget.wordModel.word, style: TextStyle(
                      fontSize: 24,
                      color: Theme.of(context).colorScheme.secondary
                  )),
                ),
              ),
            _isRevealed
              ? Column(
                children: [
                  WordCardButtonWidget(
                      text: "I knew this word",
                      backgroundColor: Consts.green,
                      foregroundColor: Colors.white,
                      action: () {
                        setState(() {
                          _isRevealed = false;
                          learningPoolProvider.updateWord(true);
                        });
                      }
                  ),
                  WordCardButtonWidget(
                      text: "I didn't know this word",
                      backgroundColor: Consts.red,
                      foregroundColor: Colors.white,
                      isLast: true,
                      action: () {
                        setState(() {
                          _isRevealed = false;
                          learningPoolProvider.updateWord(false);
                        });
                      }
                  )
                ],
              )
              : WordCardButtonWidget(
                  text: "Reveal",
                  isLast: true,
                  action: () {
                    setState(() {
                      _isRevealed = true;
                    });
                  }
              )
          ],
        )
      ),
    );
  }
}
