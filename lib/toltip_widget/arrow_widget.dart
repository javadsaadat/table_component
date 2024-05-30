import 'package:flutter/material.dart';
import 'package:table_component/toltip_widget/arrow_design.dart';

class ArrowWidget extends StatelessWidget {
  final Size size;
  final Color color;
  final bool isInverted;

  const ArrowWidget({
    super.key,
    this.size = const Size(16.0, 16.0),
    this.color = Colors.white,
    this.isInverted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(-size.width / 2, 0),
      child: CustomPaint(
        size: size,
        painter: ArrowDesign(
          size: size,
          color: color,
          isInverted: isInverted,
        ),
      ),
    );
  }
}
