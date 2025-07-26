import 'package:flutter/material.dart';

class ProgressBarWidget extends StatelessWidget {

  final int total;
  final int fraction;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const ProgressBarWidget({
    super.key,
    required this.total,
    required this.fraction,
    this.backgroundColor,
    this.foregroundColor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 14,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor
        ),
        child: total > 0 && fraction > 0
          ? FractionallySizedBox(
            heightFactor: 1,
            widthFactor: fraction/total,
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                  color: foregroundColor ?? Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(7),
                      bottomLeft: const Radius.circular(7),
                      topRight: total == fraction
                          ? const Radius.circular(7)
                          : Radius.zero,
                      bottomRight: total == fraction
                          ? const Radius.circular(7)
                          : Radius.zero
                  )
              ),
            ),
          )
          : const SizedBox.shrink()
    );
  }
}
