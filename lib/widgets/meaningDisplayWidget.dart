import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabb/providers/wordMeaningsProvider.dart';

class MeaningDisplayWidget extends StatelessWidget {
  const MeaningDisplayWidget({
    super.key,
    required this.partOfSpeech,
    required this.definition,
    this.example,
    required this.selectable,
    required this.hasViewAllButton,
    this.index
  });

  final String partOfSpeech;
  final String definition;
  final int? index;
  final String? example;
  final bool selectable;
  final bool hasViewAllButton;

  @override
  Widget build(BuildContext context) {
    WordMeaningsProvider wordMeaningsProvider = Provider.of<WordMeaningsProvider>(context);
    return Consumer<WordMeaningsProvider>(
      builder: (context, provider, child) {
        return Card(
          elevation: 4,
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                border: Border.all(
                    color: selectable && wordMeaningsProvider.isMeaningSelected(partOfSpeech, index!)
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
                    width: selectable && wordMeaningsProvider.isMeaningSelected(partOfSpeech, index!)
                        ? 2
                        : 0.5
                ),
                borderRadius: BorderRadius.circular(4)
            ),
            child: child,
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(partOfSpeech, style: const TextStyle(
                  fontSize: 17,
                  fontStyle: FontStyle.italic
              ),),
              Visibility(
                visible: hasViewAllButton,
                child: TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                      minimumSize: MaterialStateProperty.all(Size.zero),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      print("View all");
                    },
                    child: Text("View All", style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12
                    ),)),
              )
            ],
          ),
          const SizedBox(height: 15,),
          Text(definition, style: const TextStyle(
              fontSize: 13.5
          ),),
          const SizedBox(height: 10),
          example != null
              ? const Text("Example", style: TextStyle(
              fontSize: 17,
              fontStyle: FontStyle.italic
          ),)
              : SizedBox.shrink(),
          example != null
              ? const SizedBox(height: 15,)
              : const SizedBox.shrink(),
          example != null
              ? Text(example!, style: const TextStyle(
              fontSize: 13.5
          ),)
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
