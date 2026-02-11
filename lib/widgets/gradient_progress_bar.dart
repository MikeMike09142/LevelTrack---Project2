import 'package:flutter/material.dart';

class GradientProgressBar extends StatelessWidget {
  final double value; // 0.0 - 1.0
  final double height;
  final BorderRadius borderRadius;
  final List<Color> gradientColors;
  final List<double>? stops; // Optional stops for the gradient
  final Color backgroundColor;
  final bool fixedGradient; // If true, the gradient spans the full width and is revealed by the mask.

  const GradientProgressBar({
    super.key,
    required this.value,
    required this.gradientColors,
    this.stops,
    this.height = 8,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.backgroundColor = const Color(0x40FFFFFF),
    this.fixedGradient = false,
  });

  @override
  Widget build(BuildContext context) {
    final double clamped = value.clamp(0.0, 1.0);
    final bool solidFill = gradientColors.length == 1 ||
        (gradientColors.length >= 2 && gradientColors.first.toARGB32() == gradientColors.last.toARGB32());
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
              // Progress fill
              if (fixedGradient && !solidFill)
                ClipRect(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    widthFactor: clamped,
                    child: Container(
                      width: constraints.maxWidth, // Gradient spans full width
                      height: height,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: gradientColors,
                          stops: stops,
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                  ),
                )
              else
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
                              stops: stops,
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