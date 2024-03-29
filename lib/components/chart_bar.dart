import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;

  const ChartBar({
    required this.percentage,
    required this.value,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraint) {
        return Column(
          children: [
            SizedBox(
              height: constraint.maxHeight * 0.15,
              child: FittedBox(
                child: Text(value.toStringAsFixed(2)),
              ),
            ),
            SizedBox(height: constraint.maxHeight * 0.05),
            SizedBox(
              height: constraint.maxHeight * 0.6,
              width: 10,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      color: const Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: percentage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: constraint.maxHeight * 0.05),
            SizedBox(
              height: constraint.maxHeight * 0.15,
              child: FittedBox(child: Text(label)),
            ),
          ],
        );
      },
    );
  }
}
