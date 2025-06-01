import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabb/providers/addWordProvider.dart';
import 'package:vocabb/providers/loadingProvider.dart';
import 'package:vocabb/widgets/appBarWidget.dart';
import 'package:vocabb/widgets/newWordWidget.dart';
import 'package:vocabb/widgets/selectMeaningWidget.dart';

class AddWordPage extends StatelessWidget {
  const AddWordPage({
    super.key,
    required this.poolName
  });

  final String poolName;

  @override
  Widget build(BuildContext context) {
    AddWordProvider addWordProvider = Provider.of<AddWordProvider>(context);
    LoadingProvider loadingProvider = Provider.of<LoadingProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(35),
        child: AppBarWidget(
          leadingIcon: Icons.chevron_left,
          action: () {
            addWordProvider.setNewWordState(NewWordState.addingWord);
            loadingProvider.setLoading(false);
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            Text("New Word", style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 24,
                fontWeight: FontWeight.bold
            ),),
            const SizedBox(height: 20,),
            addWordProvider.getNewWordState == NewWordState.addingWord
              ? NewWordWidget()
              : SelectMeaningWidget(poolName: poolName)
          ]
        ),
      ),
    );
  }
}
