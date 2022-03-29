import 'networking.dart';

const apiKey = 'FD896BBF-DC22-41FB-9485-CEEA8E6D7009';

//https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=FD896BBF-DC22-41FB-9485-CEEA8E6D7009
const coinApiURL = 'https://rest.coinapi.io/v1/exchangerate';

class Price {
  Future<double> getCoinPrice(String coinName, String currencyName) async {
    String url = '$coinApiURL/$coinName/$currencyName?apikey=$apiKey';
   
    NetworkHelper networkHelper = NetworkHelper(url);
    var priceData = await networkHelper.getData();

    return priceData != null ? priceData['rate'] : 0;
  }
}
