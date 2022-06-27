import 'package:gsheets/gsheets.dart';

class GoogleSheetsApi {
  static const _credential = r'''{
    
    paste your crediantial

  }''';

  static const _spreadSheetId = 'paste your spreadsheet it';
  static final _gsheets = GSheets(_credential);
  static Worksheet? _worksheet;

  static int numberoFTransactions = 0;
  static List<List<dynamic>> currentTransactions = [];
  static bool isLoading = true;

  Future init() async {
    final ss = await _gsheets.spreadsheet(_spreadSheetId);
    _worksheet = ss.worksheetByTitle('ToDo');
    countRow();
  }

  static Future countRow() async {
    while (await _worksheet!.values
            .value(column: 1, row: numberoFTransactions + 1) !=
        '') {
      numberoFTransactions++;
    }
    loadTransactions();
  }

  static Future loadTransactions() async {
    if (_worksheet == null) {
      return null;
    }
    for (int i = 0; i < numberoFTransactions; i++) {
      final String transactionName =
          await _worksheet!.values.value(column: 1, row: i + 1);
      final String transactionAmount =
          await _worksheet!.values.value(column: 2, row: i + 1);
      final String transactionType =
          await _worksheet!.values.value(column: 3, row: i + 1);

      if (currentTransactions.length < numberoFTransactions) {
        currentTransactions
            .add([transactionName, transactionAmount, transactionType]);
      }
    }
    isLoading = false;
  }

  static Future insert(String name, String amount, bool _isIncome) async {
    if (_worksheet == null) return;
    numberoFTransactions++;
    currentTransactions.add([
      name,
      amount,
      _isIncome == true ? 'Expense' : 'Income',
    ]);
    await _worksheet!.values.appendRow([
      name,
      amount,
      _isIncome == true ? 'Expense' : 'Income',
    ]);
  }

  static double calculateIncome() {
    double totallIncome = 0;
    for (int i = 0; i < currentTransactions.length; i++) {
      if (currentTransactions[i][2] == 'Income') {
        totallIncome += double.parse(currentTransactions[i][1]);
      }
    }
    return totallIncome;
  }

  static double calculateExpense() {
    double totallExpense = 0;
    for (int i = 0; i < currentTransactions.length; i++) {
      if (currentTransactions[i][2] == 'Expense') {
        totallExpense += double.parse(currentTransactions[i][1]);
      }
    }
    return totallExpense;
  }
}
