import 'package:flutter/material.dart';

import '../consts/consts.dart';

class WordListWidget extends StatefulWidget {

  final List<String> words;

  const WordListWidget({
    required this.words,
    super.key
  });

  @override
  State<WordListWidget> createState() => _WordListWidgetState();
}

class _WordListWidgetState extends State<WordListWidget> {

  late List<bool> _isSelected;
  int _previousIndex = 0;

  @override
  void initState() {
    _isSelected = <bool>[];
    for (int i = 0; i < widget.words.length; i++) {
      _isSelected.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.words.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 8.5, bottom: 8.5, left: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    print("Word pressed");
                    setState(() {
                      if (_previousIndex != index) {
                        _isSelected[_previousIndex] = false;
                      }
                      _isSelected[index] = !_isSelected[index];
                      _previousIndex = index;
                    });
                  },
                  child: Text(widget.words[index], style: TextStyle(
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
                  child: Card(
                    elevation: 4,
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
                          width: 0.5
                        ),
                        borderRadius: BorderRadius.circular(4)
                      ),
                      width: size.width,
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("verb", style: TextStyle(
                            fontSize: 17,
                            fontStyle: FontStyle.italic
                          ),),
                          SizedBox(height: 15,),
                          Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis molestie neque nec eros fringilla aliquam. Nulla libero sapien, molestie eu.", style: TextStyle(
                            fontSize: 13.5
                          ),),
                          SizedBox(height: 10),
                          Text("Example", style: TextStyle(
                              fontSize: 17,
                              fontStyle: FontStyle.italic
                          ),),
                          SizedBox(height: 15,),
                          Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse ullamcorper.", style: TextStyle(
                            fontSize: 13.5
                          ),)
                        ],
                      ),
                    ),
                  ),
                )

              ],
            ),
          );
        }
      );
  }
}


