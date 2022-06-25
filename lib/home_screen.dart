import 'dart:async';

import 'package:expence_tracker/google_sheets_api.dart';
import 'package:expence_tracker/top_balance_card.dart';
import 'package:flutter/material.dart';

import 'my_transactions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isTimeStarted = false;
  void startLoading() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (GoogleSheetsApi.isLoading == false) {
        setState(() {
          timer.cancel();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (GoogleSheetsApi.isLoading == true && isTimeStarted == false) {
      startLoading();
    }
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(children: [
        const TopBlanceCard(
          balance: ' \$ 5000',
          income: '\$500',
          expence: '\$100',
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: Container(
              child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: GoogleSheetsApi.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.separated(
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemCount:
                                GoogleSheetsApi.currentTransactions.length,
                            itemBuilder: (context, index) => MyTransactions(
                              isIncomeOrExpence:
                                  GoogleSheetsApi.currentTransactions[index][2],
                              transactionName:
                                  GoogleSheetsApi.currentTransactions[index][0],
                              amount: GoogleSheetsApi.currentTransactions[index]
                                  [1],
                            ),
                          ),
                  )
                ],
              ),
            ),
          )),
        ),
        Container(
          width: 80,
          height: 80,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          decoration: const BoxDecoration(
              color: Colors.black54, shape: BoxShape.circle),
        ),
        const SizedBox(
          height: 10,
        ),
      ]),
    );
  }
}
