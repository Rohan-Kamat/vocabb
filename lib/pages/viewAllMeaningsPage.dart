import 'package:flutter/material.dart';
import 'package:vocabb/models/wordModel.dart';
import 'package:vocabb/widgets/appBarWidget.dart';
import 'package:vocabb/widgets/meaningDisplayWidget.dart';

class ViewAllMeaningsPage extends StatefulWidget {
  final WordModel wordModel;

  const ViewAllMeaningsPage({
    super.key,
    required this.wordModel
  });

  @override
  State<ViewAllMeaningsPage> createState() => _ViewAllMeaningsPageState();
}

class _ViewAllMeaningsPageState extends State<ViewAllMeaningsPage> with SingleTickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.wordModel.meanings.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar:  PreferredSize(
        preferredSize: const Size.fromHeight(35),
        child: AppBarWidget(
          leadingIcon: Icons.chevron_left,
          action: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(widget.wordModel.word, style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary
            ),),
            const SizedBox(height: 15,),
            TabBar(
                controller: _tabController,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 3.0, color: Theme.of(context).primaryColor), // Custom underline
                  insets: const EdgeInsets.symmetric(horizontal: 25.0), // Adjust horizontal padding for compactness
                ),
                // indicatorPadding: const EdgeInsets.only(bottom: 8),// Green underline when selected
                labelColor: Theme.of(context).primaryColor,     // Color for selected tab text
                unselectedLabelColor: Theme.of(context).colorScheme.secondary,
                tabs: widget.wordModel.meanings.keys
                      .map((partOfSpeech) => Text(partOfSpeech))
                      .toList()
            ),
            const SizedBox(height: 20,),
            SizedBox(
              height: size.height*0.75,
              child: TabBarView(
                controller: _tabController,
                children:  widget.wordModel.meanings.entries.map((meaning) => ListView.separated(
                  shrinkWrap: true,
                  itemCount: meaning.value.length,
                  itemBuilder: (context, index) {
                    return MeaningDisplayWidget(
                        wordModel: widget.wordModel,
                        partOfSpeech: meaning.key,
                        index: index,
                        definition: meaning.value[index].definition,
                        example: meaning.value[index].example,
                        selectable: false,
                        hasViewAllButton: false
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 20);
                  },
                )).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
