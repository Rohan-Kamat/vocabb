import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabb/consts/consts.dart';
import 'package:vocabb/consts/enums.dart';
import 'package:vocabb/models/poolModel.dart';
import 'package:vocabb/providers/learningPoolProvider.dart';
import 'package:vocabb/widgets/LearningProgressWidget.dart';
import 'package:vocabb/widgets/appBarWidget.dart';
import 'package:vocabb/widgets/wordCardWidget.dart';

class LearnPoolPage extends StatelessWidget {

  final PoolModel poolModel;

  const LearnPoolPage({
    super.key,
    required this.poolModel
  });

  @override
  Widget build(BuildContext context) {
    LearningPoolProvider learningPoolProvider = Provider.of<LearningPoolProvider>(context);
    learningPoolProvider.initialize(poolModel);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(30),
        child: AppBarWidget(
          leadingIcon: Icons.chevron_left,
          action: () {
            learningPoolProvider.savePoolStatus();
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            SizedBox(
              width: size.width,
              child: Text(poolModel.name, textAlign: TextAlign.center, style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 24,
                fontWeight: FontWeight.bold
              )),
            ),
            const SizedBox(height: 38),
            Consumer<LearningPoolProvider>(
                builder: (context, provider, _) {
                  return WordCardWidget(
                    wordModel: provider.getNextWord
                  );
                }
            ),
            const SizedBox(height: 116),
            SizedBox(
              width: size.width*0.75,
              child: Consumer<LearningPoolProvider>(
                builder: (context, provider, _) {
                  return Column(
                    children: [
                      LearningProgressWidget(
                        title: "Mastered",
                        fraction: provider.statusWiseCount[LearningStatus.mastered]!,
                        total: provider.wordRoster.length,
                        color: Consts.green,
                      ),
                      const SizedBox(height: 27),
                      LearningProgressWidget(
                        title: "Reviewing",
                        fraction: provider.statusWiseCount[LearningStatus.reviewing]!,
                        total: provider.wordRoster.length,
                        color: Consts.yellow,
                      ),
                      const SizedBox(height: 27),
                      LearningProgressWidget(
                        title: "Learning",
                        fraction: provider.statusWiseCount[LearningStatus.learning]!,
                        total: provider.wordRoster.length,
                        color: Consts.red,
                      )
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
