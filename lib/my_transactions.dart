import 'package:flutter/material.dart';

class MyTransactions extends StatelessWidget {
  final String transactionName;
  final String amount;
  final String isIncomeOrExpence;

  var isExpenceOrIncome;
  MyTransactions({
    Key? key,
    required this.transactionName,
    required this.amount,
    required this.isIncomeOrExpence,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(10),
        color: Colors.white,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  child: const Center(
                      child: Icon(
                    Icons.monetization_on,
                    color: Colors.amberAccent,
                  )),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  transactionName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Text(
              isIncomeOrExpence == 'income'
                  ? '+ \$' + amount
                  : '-  \$' + amount,
              style: TextStyle(
                  color: isIncomeOrExpence == 'income'
                      ? Colors.green
                      : Colors.redAccent,
                  fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
