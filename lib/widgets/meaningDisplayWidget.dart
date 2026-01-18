import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabb/models/wordModel.dart';
import 'package:vocabb/pages/viewAllMeaningsPage.dart';
import 'package:vocabb/providers/poolProvider.dart';
import 'package:vocabb/providers/wordMeaningsProvider.dart';

class MeaningDisplayWidget extends StatelessWidget {
  const MeaningDisplayWidget({
    super.key,
    this.wordModel,
    required this.partOfSpeech,
    required this.definition,
    this.example,
    required this.selectable,
    required this.hasOptions,
    this.index
  });

  final WordModel? wordModel;
  final String partOfSpeech;
  final String definition;
  final int? index;
  final String? example;
  final bool selectable;
  final bool hasOptions;

  static const DELETE_VALUE = "delete";
  static const VIEW_ALL_VALUE = "view_all";

  void _handleDelete(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            content: Text("Are you sure you want to delete the word form the pool?"),
            actions: [
              OutlinedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                    foregroundColor: MaterialStateProperty.all(Colors.white)
                ),
                onPressed: () async {
                  PoolProvider poolProvider = Provider.of<PoolProvider>(context, listen: false);
                  bool res = await poolProvider.deleteWordFromPool(wordModel!);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          res
                            ? "Word Successfully deleted"
                            : "Something went wrong. Please try again",
                          style: const TextStyle(
                            color: Colors.white
                        )),
                      backgroundColor: res
                        ? Colors.green
                        : Colors.red,
                    )
                  );
                  Navigator.pop(context);
                },
                child: const Text("Yes"),
              ),
              OutlinedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Theme.of(context).scaffoldBackgroundColor),
                      side: const MaterialStatePropertyAll(BorderSide(color: Colors.red)),
                      foregroundColor: MaterialStateProperty.all(Colors.red)
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")
              )
            ],
          );
        }
    );
  }

  void _handleViewAll(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => ViewAllMeaningsPage(
            wordModel: wordModel!
        )
    ));
  }

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
                visible: hasOptions,
                child: PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert),
                  onSelected: (String value) {
                    switch (value) {
                      case DELETE_VALUE:
                        _handleDelete(context);
                        break;
                      case VIEW_ALL_VALUE:
                        _handleViewAll(context);
                        break;
                    }
                  },
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem<String>(
                      value: DELETE_VALUE,
                      child: Row(
                        children: [
                          Icon(Icons.delete, size: 20),
                          SizedBox(width: 12),
                          Text('Delete'),
                        ],
                      ),
                    ),
                    const PopupMenuItem<String>(
                      value: VIEW_ALL_VALUE,
                      child: Row(
                        children: [
                          Icon(Icons.visibility, size: 20),
                          SizedBox(width: 12),
                          Text('View all'),
                        ],
                      ),
                    ),
                  ],
                ),
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
