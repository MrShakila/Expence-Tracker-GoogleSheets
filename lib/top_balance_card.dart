import 'package:flutter/material.dart';

class TopBlanceCard extends StatelessWidget {
  final String balance;
  final String income;
  final String expence;
  const TopBlanceCard({
    Key? key,
    required this.balance,
    required this.income,
    required this.expence,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 200,
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                'B A L A N C E',
                style: TextStyle(color: Colors.grey[500], fontSize: 16),
              ),
              Text(
                balance,
                style: TextStyle(color: Colors.grey[800], fontSize: 40),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                            decoration: const BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.arrow_upward,
                                color: Colors.green,
                              ),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Income',
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 18),
                            ),
                            Text(
                              income,
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 18),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                            decoration: const BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.arrow_downward,
                                color: Colors.red,
                              ),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Expence',
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 18),
                            ),
                            Text(
                              expence,
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 18),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ])),
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade500,
                  offset: const Offset(4.0, 4.0),
                  blurRadius: 15.0,
                  spreadRadius: 1.0),
              BoxShadow(
                  color: Colors.grey.shade500,
                  offset: const Offset(-4.0, -4.0),
                  blurRadius: 15.0,
                  spreadRadius: 1.0),
            ]),
      ),
    );
  }
}
