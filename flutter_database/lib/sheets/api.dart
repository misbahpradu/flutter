import 'package:doctor_appointment_app/sheets/fields.dart';
import 'package:gsheets/gsheets.dart';

class UserSheetApi {
  static const _credentials = r'''
    {
      "type": "service_account",
      "project_id": "users-405203",
      "private_key_id": "5fe02fde8b5aa548733b62a6094253e3e4a5f5a9",
      "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCl0sNYWrwj0A39\nTXMlfe3Xi4xN99cF85Q+Z5/w2QxDCLTjcT48lXfv6/i+7ZcGH1MVDQUz1gTHCbgz\nUeFC/muDev09mcmOekJ0PB4EL0JVyv1TzArykt8usq2P6G3B1IT3uS188HnykFUl\nwpAF3D3LXj47hX2TigA0Z9qFaCzbSirFyA/fMkk2WaEwsMOJxaArBQdRGX2Ck56X\nNuLb3BJVvHvRciY70map/lfn28jmqC0yEzHkJ8J1zXZmHbsTMXf4h4sutT8XR3Wo\nr+TNd7Y9Wxz2vAvv8TvpbvIbEw8rEplOoTc9A6S0BIY3Z0zGnW5QE43puPrxD+VQ\nS2FG9wTxAgMBAAECggEAEJMqXP7GzwKZH2BaOd1mRHUJq3JyPwFLqFg1y756RAoP\nAKv9V1NuZ2AsHzOC9MT1SkWgpz+Ffzqou5J75HUnXH9S6FEirTfpxBINQwhRRl+R\npkpfLsOBBPstr5SBQg5i0xsioZos6lLEfA+AU2GiGJ2dNVhgxrpUzmgyFsMktq+A\nMXcNk3RVwk/2P49fsY4w5N20MO3egi0XLyHq63GTb+znIsDprNaPC3BmP3Mxy7I9\nRCQDEMLYkVSaNAMnSgTRmnmwkccmVC2XIIDreuZh91+Eekpqf/xjmNgmMR+P0nwV\nMgZJhrNGlJxiQIqAGtcRUc3nLfxaGZ2jqOmnl9dwMQKBgQDWhYFa6qWelHAnxMVN\n3QKdAvSci+L9VX0K4v8S6c69M2DsaWHyv6DQ9vtmzAGjP0KtBfR8QVpHiXz8yY/A\n7WudASpTdLZdx+RsqrYk6n0CxWTw+mQ/42HLHw0+TDh6CqgZYTHrFtu8nVv/wFr5\nv7yWM1G7TW/apoWL1TosZ5FwmQKBgQDF4sTVlhuK52gAZropJnM2xz2ovEfnPJvQ\nbz+dytsDOTm0hqGeYxXzS3P40reU2V42vKUEhtrBHN0t8HvBGrMLJkmClackeZYK\nnretMbNWXInH6R64SddfeB6U+TJCbr6rfzYzSQNEs5pawe8i0ZswQtnWcdMVSqN3\nhWQ2DhD2GQKBgH3Bp/I3Sj3rgNAfbxbVMBoBSIqZCsk+G16NccCRpeuOOgx9PrlC\nkzDNCNXbVD5x8FFkA03wNc9oDwhV1Nrhk8tninuAGQRjEUqOzNZZTE2akDEgaDJ3\nxrV/j5Dst9L7ek3eh5fsP4aTrQIBrpNoTlKy5P/rRl4kbndp2X98e2tJAoGAB6hG\nxZ0RY8agl6NiAMWkH7KGCEmA3snRnbcwVwLKhs1oFjw/dMmQx+Fbk31T7UacBrI2\nEH7HaEGdrXFo2IgX9Y59ubfgx+CMlcyefu01a1oZWssCjU8OLnuPc2RRNZDjf+9k\nQYfJwJbSmkB26HoD71Im681rxZ8lxDI9NnpE3cECgYEAiHQQWBva1fZeh3nn85P9\nvpf4K1nwZfe7AQTFJpWKNxpGQEXqO5B3TajPH9B4TgOlSV30Lrgha8RTaOasPkgL\nuiZjU7usEgvJvyLMlAhRCUECkKekss3SnqXmQ30Jw6l1W9CZqNOeKGD5emlyn3cA\nD2qEq36EdpCIh7yIPCQfl+I=\n-----END PRIVATE KEY-----\n",
      "client_email": "users-78@users-405203.iam.gserviceaccount.com",
      "client_id": "102983281989851692863",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/users-78%40users-405203.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    }
  ''';
  static final _spreadsheetId = '15WSCWeueFJqtc7TlOPujQTcDp9HIYrvEDOAbkgR5YfE';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _userSheet;

  static Future<void> init() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
      _userSheet = await _getWorksheet(spreadsheet, title: 'Users');

      final firstRow = UserFields.getFields();
      await _userSheet!.values.insertRow(1, firstRow);
    } catch (e) {
      print('Init Error: $e');
    }
  }

  static Future<Worksheet> _getWorksheet(
      Spreadsheet spreadsheet, {
        required String title,
      }) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future<int> getRowCount() async {
    if (_userSheet == null) return 0;

    final lastRow = await _userSheet!.values.lastRow();
    return lastRow == null ? 0 : int.tryParse(lastRow.first) ?? 0;
  }

  static Future<void> insert(List<Map<String, dynamic>> rowList) async {
    if (_userSheet == null) return;

    try {
      await _userSheet!.values.map.appendRow(rowList as Map<String, dynamic>);
    } catch (e) {
      print('Insert Error: $e');
    }
  }
}
