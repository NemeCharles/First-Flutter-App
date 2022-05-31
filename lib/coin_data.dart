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
  'SOL',
  'ADA',
];

const apiKey = 'B6383058-A208-4C38-8550-4E103F912B40';

class CoinData {
  Future<dynamic> getData(String cryptoCoin, String dropdownValue) async {
    var response = await http.get(Uri.parse('https://rest.coinapi.io/v1/exchangerate/$cryptoCoin/$dropdownValue?apikey=$apiKey'));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body)['rate'];
      return data;
    }else{print(response.statusCode);}
  }
}

class CoinDataIOS {
  Future<dynamic> getData(String dropdownValue) async {
    Map<String, String> cryptoPrices = {};
    for(var cryptoCoin in cryptoList) {
      var response = await http.get(Uri.parse('https://rest.coinapi.io/v1/exchangerate/$cryptoCoin/$dropdownValue?apikey=$apiKey'));
      if(response.statusCode == 200){
        var data = jsonDecode(response.body)['rate'];
        cryptoPrices[cryptoCoin] = data.toStringAsFixed(2);
      }else{print(response.statusCode);}
    }
    return cryptoPrices;
  }
}