import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double dayExpenditure;
  final double expenditurePctOfTotal;

  ChartBar(this.label, this.dayExpenditure, this.expenditurePctOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: [
            Container(
              height: 20,
              child: FittedBox(
                child: Text(
                  '\$${dayExpenditure.toStringAsFixed(0)}',
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
            ),
            SizedBox(height: 4),
            Container(
              height: constraints.maxHeight * 0.6,
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
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: expenditurePctOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        );
      },
    );
  }
}
