import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const apiKey = 'API-KEY';
const apiURL = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {
  Future<dynamic> getCoinData(String currency) async {
    Map<String, int> coinDataResponse = {};
    for (String crypto in cryptoList) {
      var response = await http.get('$apiURL/$crypto/$currency?apiKey=$apiKey');

      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double coinPrice = decodedData['rate'];
        coinDataResponse[crypto] = coinPrice.round();
      } else {
        print(response.body);
      }
    }

    return coinDataResponse;
  }
}
