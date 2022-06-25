import 'package:gsheets/gsheets.dart';

class GoogleSheetsApi {
  static const _credential = r'''{
    
palce your api crediantial here
  }''';

  static const _spreadSheetId = ' place Your spreadsheetId Here';
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
}
