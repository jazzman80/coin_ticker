import 'package:http/http.dart' as http;
import 'constants.dart';
import 'dart:convert';

Future<String> getExchangeRate(String sellingCurrency) async {
  var url =
      Uri.parse('https://rest.coinapi.io/v1/exchangerate/BTC/$sellingCurrency');
  http.Response response = await http.get(
    url,
    headers: {'X-CoinAPI-Key': aPIKey},
  );

  if (response.statusCode == 200) {
    String rate = jsonDecode(response.body)['rate'].toStringAsFixed(0);
    return rate;
  } else {
    return '?';
  }
}
