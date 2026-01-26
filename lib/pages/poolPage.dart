import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabb/models/poolModel.dart';
import 'package:vocabb/pages/addWordPage.dart';
import 'package:vocabb/pages/learnPoolPage.dart';
import 'package:vocabb/providers/poolProvider.dart';
import 'package:vocabb/widgets/appBarWidget.dart';
import 'package:vocabb/widgets/floatingActionButtonWidget.dart';
import 'package:vocabb/widgets/poolNameWidget.dart';
import 'package:vocabb/widgets/ratingWidget.dart';
import 'package:vocabb/widgets/wordListWidget.dart';

class PoolPage extends StatelessWidget {

  final PoolModel poolModel;

  PoolPage({
    super.key,
    required this.poolModel
  });


  @override
  Widget build(BuildContext context) {
    PoolProvider poolProvider = Provider.of<PoolProvider>(context, listen: false);
    poolProvider.initialize(poolModel);

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(30),
          child: AppBarWidget(
            leadingIcon: Icons.chevron_left,
            action: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 28),
              Container(
                color: Theme.of(context).colorScheme.secondary,
                padding: const EdgeInsets.only(
                    top: 20, bottom: 20, left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PoolNameWidget(poolName: poolProvider.getPoolModel.name),
                        IconButton(
                            onPressed: () {
                              print("Pool settings pressed");
                            },
                            icon: Icon(Icons.settings,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor))
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(poolProvider.getPoolModel.user,
                        style: TextStyle(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            fontSize: 16)),
                    const SizedBox(height: 8),
                    RatingWidget(rating: poolProvider.getPoolModel.rating, size: 16),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 60,
                      child: Center(
                        child: Text(
                          "Desciption",
                          style: TextStyle(
                              color: Theme.of(context).scaffoldBackgroundColor),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: 38,
                          width: 176,
                          child: Consumer<PoolProvider>(
                            builder: (context, provider, _) {
                              return OutlinedButton(
                                  onPressed: provider.isPoolEmpty
                                    ? null
                                    : () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => LearnPoolPage(poolModel: provider.getPoolModel)));
                                    },
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: Theme.of(context).primaryColor,
                                    foregroundColor: Colors.white,
                                    disabledBackgroundColor: Theme.of(context).primaryColor.withOpacity(0.5),
                                    disabledForegroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5)
                                  ),
                                  child: Text("Learn Pool")
                              );
                            }
                          )
                        ),
                        SizedBox(
                          height: 38,
                          width: 176,
                          child: OutlinedButton(
                              onPressed: () {
                                print("Learn pool");
                              },
                              style: OutlinedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                foregroundColor:
                                    Theme.of(context).colorScheme.secondary,
                              ),
                              child: const Text("Rate Pool")),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Consumer<PoolProvider>(
                    builder: (context, provider, _) {
                      print("WordList length: ${provider.getPoolModel.words.length}");
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Words (${provider.getPoolModel.totalWordsCount})",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          provider.getPoolModel.words.isEmpty
                            ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                    "Add a word by clicking on the plus icon on the bottom right corner",
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary
                                          .withOpacity(0.7),
                                      fontSize: 15,
                                    ),
                                    textAlign: TextAlign.center),
                              ),
                            )
                            : WordListWidget(poolModel: provider.getPoolModel)
                        ],
                      );
                    }
                  ))
            ],
          ),
        ),
        floatingActionButton: Consumer<PoolProvider>(
          builder: (context, provider, _) {
            return FloatingActionButtonWidget(onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddWordPage(poolModel: provider.getPoolModel)));
            });
          }
        ));
  }
}
