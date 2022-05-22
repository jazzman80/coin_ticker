import 'package:http/http.dart' as http;
import 'constants.dart';
import 'dart:convert';

Future<String> getExchangeRate() async {
  var url = Uri.parse('https://rest.coinapi.io/v1/exchangerate/BTC/USD');
  http.Response response = await http.get(
    url,
    headers: {'X-CoinAPI-Key': aPIKey},
  );
  String rate = jsonDecode(response.body)['rate'].toStringAsFixed(0);
  return '1 BTC = $rate USD';
}
