import 'package:flutter/material.dart';

class GradientProgressBar extends StatelessWidget {
  final double value; // 0.0 - 1.0
  final double height;
  final BorderRadius borderRadius;
  final List<Color> gradientColors;
  final Color backgroundColor;

  const GradientProgressBar({
    super.key,
    required this.value,
    required this.gradientColors,
    this.height = 8,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.backgroundColor = const Color(0x40FFFFFF),
  });

  @override
  Widget build(BuildContext context) {
    final double clamped = value.clamp(0.0, 1.0);
    final bool solidFill = gradientColors.length == 1 ||
        (gradientColors.length >= 2 && gradientColors.first.value == gradientColors.last.value);
    return ClipRRect(
      borderRadius: borderRadius,
      child: LayoutBuilder(
        builder: (ctx, constraints) {
          return Stack(
            children: [
              // Track
              Container(
                width: constraints.maxWidth,
                height: height,
                color: backgroundColor,
              ),
              // Progress fill with gradient
              FractionallySizedBox(
                widthFactor: clamped,
                alignment: Alignment.centerLeft,
                child: Container(
                  height: height,
                  decoration: solidFill
                      ? BoxDecoration(color: gradientColors.first)
                      : BoxDecoration(
                          gradient: LinearGradient(
                            colors: gradientColors,
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}