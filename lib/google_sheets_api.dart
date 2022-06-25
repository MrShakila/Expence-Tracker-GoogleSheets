import 'package:gsheets/gsheets.dart';

class GoogleSheetsApi {
  static const _credential = r'''{
    
  "type": "service_account",
  "project_id": "flutter-gsheets-354205",
  "private_key_id": "91c855a53a2137771bccfb865caa1385b375d013",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDQ9Fd5clnZWWCv\n8GUZAlr+brSjHiImPlQ0sLKuR4L6w0ub1ISZXjrorKwY7FtDE/0yRUpmrGr5IPNI\ncJzDhi4Q4cczAp3aMGzEhGcgMmOfGy7gJ3WODRVsqX/d5yfgrdXO63jClkfCiTOl\n2xSKNnzVtgpSXZD/aQhgNgvOw60DZXjxNTj/BlhncOzhAH3ivHNbgXxt0KH5VuL+\nlblDb6kTszC4XxXZG3yPSOVOPpPAuZORfWhcSGi2VfULmifs9rLYh0x8vi6tn+Kx\nIUCE+vIopLoy4DqnPTNhC0vcdBzMu0g2kgQy/N5ALwH04oaCrJpnVCIwuqwX3PPH\nSxWUdDC/AgMBAAECggEAAbCQIyN4KdchdIcTKtRCeFfcmsdiGihgLlQgirG0zt2e\nlMmW49XWbbqNk7dnHksq0VYipRRKZGRYPl4QmsTubZYiu+SYo6UpwYrCPuHUgiv7\nhlOqIR2/Rt/JZuE+ErvbSX30gth4Lp+ne7A2HM89wgiBPium1bWZJgKjuFe9H2Nk\n0XRsub4J1NEKMEzDyyOtdMkt8MFiq490naGDwD02O83P8r4SnkYWYObduE8fyyLa\n3LIUbXPVFrbFoSAkl8+i5/Xq+5JamkV5jthzXG8OlFcgubKR5V8UwUaSNTDMBwJ1\nFDFfwpt8KNjDPgmtjq85YG+JicyvdkZJILxL7KcDfQKBgQDu7x+5bN/wTEM2AmXt\niXFVytb2PGPgJwytIbb6d5SM96+3r4/gyLGndGk1wKmQavOf+uRuOI6Z6xTFhxei\njQoDdHCbwLjBCLb6c9BqrkD/ZusjVhxHO8gUCfieMEUqHMj1jPJt02eQKqTIqgza\nUE5D4ImArmwV9TWCWm/0QxWmZQKBgQDf4QtvLYdae8b9EGr+YfvZNkm/k/DCerQZ\nlLh5UX54MqhjYcrtVJeE2VIEj2wgeKFLxuTU1f7rmy8JCMWwoVeFWwhkshYHLRy2\nqiW5oszt+c7GV3xW4gVrkIwn6E1/f3/7b5r3H4jSMBI3WFMI72wmWSp5U8BeMdyz\nUI87Y+dmUwKBgQCDj9uSCCcOc4+Wj598Oe/T44qVrw73f8j1E9li9LExJbj1lY/N\nn/RiVjEQTfOP97QJ5OYe4rlyewTG9unGsY5P9K+Es4uHjrriER8zfpt/hjX3ERUl\nC//ROORShhWvaIYm3uMmIf+mXDS74RaOpyVRLrPHzULqnEhIbG+0ubOUGQKBgA92\nDUIaVNSs46sqbRkwTyJLG4C9iM0FiFaT7MGEHUXTyclDQa5uPyCPmZhzBzae3hTL\noZYJSVegGfl3v59ZJSAyjzvVCKxqMydyTLSrR5fPvrX36MBfT5yEGQnQgzmg5ofI\nx1z1so9BfqCP2vws/L0RP1utqwVWUDWaBKpHVf29AoGARhgfbdmHLSzFtlNai13j\nWDteGxC0EvsRwIDbo5zBPo4KL4lKjSqqGePL7ZInw/RPz+smPOel0/c8Z8/OROQ6\n86d/1+0BzIr57/lwGL4/YaX8REm4M42nk2okhX6KxkCHttS/rbEnCHhvsHefls6K\n6/AC+JeVuOCMziKVnQd5Gwg=\n-----END PRIVATE KEY-----\n",
  "client_email": "expence-tracker@flutter-gsheets-354205.iam.gserviceaccount.com",
  "client_id": "112675111296938695537",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/expence-tracker%40flutter-gsheets-354205.iam.gserviceaccount.com"


  }''';

  static const _spreadSheetId = '1Io1jeS4eUjevJMuucg4XsOzilTPhjMH3iFFAoRoUHZ8';
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
      _isIncome == true ? 'Expense':'Income'  ,
    ]);
    await _worksheet!.values.appendRow([
      name,
      amount,
      _isIncome == true ? 'Expense':'Income' ,
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
