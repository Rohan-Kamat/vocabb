import 'package:flutter/material.dart';

class WordCardButtonWidget extends StatelessWidget {

  final Color? backgroundColor;
  final Color? foregroundColor;
  final String text;
  final bool? isLast;
  final VoidCallback action;

  const WordCardButtonWidget({
    super.key,
    this.backgroundColor,
    this.foregroundColor,
    required this.text,
    required this.action,
    this.isLast
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      splashColor: Color.alphaBlend(Colors.black.withOpacity(0.2),
          backgroundColor ?? Theme.of(context).scaffoldBackgroundColor),
      child: Container(
        height: 40,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
            borderRadius: isLast == true
              ? const BorderRadius.only(
                  bottomRight: Radius.circular(4),
                  bottomLeft: Radius.circular(4)
              )
              : BorderRadius.zero
        ),
        child: Center(
          child: Text(text, style: TextStyle(
              color: foregroundColor ?? Theme.of(context).colorScheme.tertiary,
              fontSize: 15
          )),
        ),
      ),
    );
  }
}
