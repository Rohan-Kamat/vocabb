import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabb/models/wordModel.dart';
import 'package:vocabb/pages/viewAllMeaningsPage.dart';
import 'package:vocabb/providers/addWordProvider.dart';
import 'package:vocabb/providers/loadingProvider.dart';
import 'package:vocabb/providers/poolProvider.dart';
import 'package:vocabb/providers/wordMeaningsProvider.dart';
import 'package:vocabb/services/apiServices.dart';

class NewWordWidget extends StatelessWidget {
  NewWordWidget({super.key});

  final TextEditingController _newWordController = TextEditingController();
  
  WordModel? _getExistingWordInPool(String word, PoolProvider poolProvider) {
    for (WordModel wordModel in poolProvider.getPoolModel.words) {
      if (wordModel.word.toLowerCase() == word.toLowerCase()) {
        return wordModel;
      }
    }
  }

  void _showWordExistsDialog(BuildContext context, WordModel wordModel) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            content: Text("Word already exists in Pool."),
            actions: [
              OutlinedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                    foregroundColor: MaterialStateProperty.all(Colors.white)
                ),
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ViewAllMeaningsPage(wordModel: wordModel)));
                },
                child: const Text("Go to Word"),
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


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AddWordProvider addWordProvider = Provider.of<AddWordProvider>(context);
    LoadingProvider loadingProvider = Provider.of<LoadingProvider>(context);
    PoolProvider poolProvider = Provider.of<PoolProvider>(context);
    WordMeaningsProvider wordMeaningsProvider = Provider.of<WordMeaningsProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _newWordController,
          decoration: InputDecoration(
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.tertiary.withOpacity(0.7),
                ),
              ),
              hintText: "Enter new word",
              hintStyle: TextStyle(
                color: Theme.of(context).colorScheme.tertiary.withOpacity(0.7),
              )
          ),
        ),
        const SizedBox(height: 20,),
        Flex(
            direction: Axis.horizontal,
            children:[
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Consumer<LoadingProvider>(
                    builder: (context, provider, _) {
                      return OutlinedButton(
                          // Do not do anything if button is clicked
                          // when the word is being fetched from API
                          onPressed: loadingProvider.isLoading
                            ? null
                            : () async {
                                if (_newWordController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text("Word cannot be blank", style: TextStyle(
                                              color: Colors.white
                                          )),
                                          backgroundColor: Colors.red
                                      )
                                  );
                                  return;
                                }
                                WordModel? existingWordInPool = _getExistingWordInPool(_newWordController.text, poolProvider);
                                if (existingWordInPool != null) {
                                  _showWordExistsDialog(context, existingWordInPool);
                                  return;
                                }
                                loadingProvider.setLoading(true);
                                FocusScope.of(context).unfocus();
                                WordModel? wordMeanings = await ApiServices.getWordMeanings(_newWordController.text);
                                loadingProvider.setLoading(false);
                                if (wordMeanings == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("An error occured in fetching the word details")
                                    )
                                  );
                                } else {
                                  wordMeaningsProvider.setWord(wordMeanings);
                                  addWordProvider.setNewWordState(NewWordState.selectingMeanings);
                                  _newWordController.clear();
                                }
                            },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Theme.of(context).primaryColor
                          ),
                          child: const Text("Search")
                      );
                    }
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                          side: const MaterialStatePropertyAll(BorderSide(color: Colors.red)), // Border color and width
                          foregroundColor: const MaterialStatePropertyAll(Colors.red),
                          backgroundColor: MaterialStatePropertyAll(Theme.of(context).scaffoldBackgroundColor)// Text color
                      ),
                      child: const Text("Cancel"),
                    ),
                  ))
            ]
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: size.height * 0.6,
          child: loadingProvider.isLoading
            ? Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
            )
            : null
        )
      ],
    );
  }
}
