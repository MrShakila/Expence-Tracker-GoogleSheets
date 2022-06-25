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
  final _amountController = TextEditingController();
  final _nameController = TextEditingController();
  bool _isIncome = false;

  void startLoading() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (GoogleSheetsApi.isLoading == false) {
        setState(() {
          timer.cancel();
        });
      }
    });
  }

  void _addNewTransaction1() {
    GoogleSheetsApi.insert(
        _nameController.text, _amountController.text, _isIncome);
    setState(() {});
  }

  void addTrasaction() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              title: const Text('Add New Trasaction'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('Income'),
                        Switch(
                            value: _isIncome,
                            onChanged: (newValue) {
                              setState(() {
                                _isIncome = newValue;
                              });
                            }),
                        const Text('Expence')
                      ],
                    ),
                    SizedBox(
                      height: 40,
                      child: Center(
                        child: TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                              hintText: 'What For',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12))),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 40,
                      child: Center(
                        child: TextField(
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: false,
                          ),
                          controller: _amountController,
                          decoration: InputDecoration(
                              hintText: 'Amount',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                MaterialButton(
                    color: Colors.grey[600],
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                MaterialButton(
                    color: Colors.grey[600],
                    child: const Text(
                      'Enter',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      if (_amountController.text.isNotEmpty &&
                          _nameController.text.isNotEmpty) {
                        _addNewTransaction1();
                        _amountController.clear();
                        _nameController.clear();
                        Navigator.of(context).pop();
                      } else {
                        const AlertDialog(
                          content: Text('Please Fill All The Fields'),
                          title: Text('Error'),
                        );
                      }
                    })
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    if (GoogleSheetsApi.isLoading == true && isTimeStarted == false) {
      startLoading();
    }
    return Scaffold(
      floatingActionButton: ElevatedButton(
        child: const Text('Add New Expence'),
        onPressed: () {
          return addTrasaction();
        },
      ),
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(children: [
        TopBlanceCard(
          balance: ' \$' +
              (GoogleSheetsApi.calculateIncome() -
                      GoogleSheetsApi.calculateExpense())
                  .toString(),
          income: '\$' + GoogleSheetsApi.calculateIncome().toString(),
          expence: '\$' + GoogleSheetsApi.calculateExpense().toString(),
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
        const SizedBox(
          height: 10,
        ),
      ]),
    );
  }
}
