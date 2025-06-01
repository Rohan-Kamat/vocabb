import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabb/models/wordModel.dart';
import 'package:vocabb/providers/addWordProvider.dart';
import 'package:vocabb/providers/wordMeaningsProvider.dart';
import 'package:vocabb/services/dbServices.dart';
import 'package:vocabb/widgets/meaningDisplayWidget.dart';

class SelectMeaningWidget extends StatefulWidget {
  const SelectMeaningWidget({
    super.key,
    required this.poolName
  });

  final String poolName;

  @override
  State<SelectMeaningWidget> createState() => _SelectMeaningWidgetState();
}

class _SelectMeaningWidgetState extends State<SelectMeaningWidget> with SingleTickerProviderStateMixin{

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    final tabCount = context.read<WordMeaningsProvider>().getWord!.meanings.length; // Read without listening
    _tabController = TabController(length: tabCount, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AddWordProvider addWordProvider = Provider.of<AddWordProvider>(context);
    WordMeaningsProvider wordMeaningsProvider = Provider.of<WordMeaningsProvider>(context);
    WordModel wordMeanings = wordMeaningsProvider.getWord!;
    List<Text> partsOfSpeech = wordMeanings.meanings.keys
                              .map((partOfSpeech) => Text(partOfSpeech))
                              .toList();
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            "Select all the meanings you wish to add to the pool",
            style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary.withOpacity(0.7),
              fontSize: 15,
            ),
            textAlign: TextAlign.start
        ),
        const SizedBox(height: 20,),
        Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    WordModel finalSelection = wordMeaningsProvider.getSelectedMeanings();
                    print(finalSelection.toJson());
                    DbServices.addWordToPoolByPoolName(widget.poolName, finalSelection);
                    addWordProvider.setNewWordState(NewWordState.addingWord);
                    Navigator.pop(context);
                  },
                  child: const Text("Add"),
                ),
              )
            ),
            Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                              ),
                              content: Text("Are you sure you want to cancel?"),
                              actions: [
                                OutlinedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                                      foregroundColor: MaterialStateProperty.all(Colors.white)
                                    ),
                                    onPressed: () {
                                      wordMeaningsProvider.resetState();
                                      addWordProvider.setNewWordState(NewWordState.addingWord);
                                      Navigator.pop(context);
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
                                    child: const Text("No")
                                )
                              ],
                            );
                          });
                    },
                    style: ButtonStyle(
                        side: const MaterialStatePropertyAll(BorderSide(color: Colors.red)), // Border color and width
                        foregroundColor: const MaterialStatePropertyAll(Colors.red),
                        backgroundColor: MaterialStatePropertyAll(Theme.of(context).scaffoldBackgroundColor)// Text color
                    ),
                    child: const Text("Cancel"),
                  ),
                ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabBar(
                controller: _tabController,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 3.0, color: Theme.of(context).primaryColor), // Custom underline
                  insets: const EdgeInsets.symmetric(horizontal: 25.0), // Adjust horizontal padding for compactness
                ),
                // indicatorPadding: const EdgeInsets.only(bottom: 8),// Green underline when selected
                labelColor: Theme.of(context).primaryColor,     // Color for selected tab text
                unselectedLabelColor: Theme.of(context).colorScheme.secondary,
                tabs: partsOfSpeech
            ),
            const SizedBox(height: 20,),
            SizedBox(
              height: size.height*0.6,
              child: TabBarView(
                  controller: _tabController,
                  children:  wordMeanings.meanings.entries.map((meaning) => ListView.separated(
                    shrinkWrap: true,
                    itemCount: meaning.value.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          wordMeaningsProvider.toggleMeaning(meaning.key, index);
                        },
                        child: MeaningDisplayWidget(
                            partOfSpeech: meaning.key,
                            index: index,
                            definition: meaning.value[index].definition,
                            example: meaning.value[index].example,
                            selectable: true,
                            hasViewAllButton: false
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 20);
                    },
                  )).toList(),
              ),
            )
          ],
        )
      ],
    );
  }
}
