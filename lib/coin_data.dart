import 'networking.dart';

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

class CoinData {
  String root = "https://rest.coinapi.io/v1/exchangerate/";
  String apikey = "7E94D6E2-28E7-40CE-8B70-97D04B1DA12B";

  Future<dynamic> getExchange(String from, String to) async {
    String url = "$root$from/$to?apikey=$apikey";
    var result = await Networking(url: url).getData();
    return result == null ? null : result;
  }
}
