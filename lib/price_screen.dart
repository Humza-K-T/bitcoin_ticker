import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'price_getter.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  List<DropdownMenuItem> getCurrencyList() {
    List<DropdownMenuItem> currencyList = [];

    for (int i = 0; i < currenciesList.length; i++) {
      Text currency = Text(
        currenciesList[i],
        style: TextStyle(color: Colors.white),
      );

      currencyList.add(DropdownMenuItem(
        child: Center(child: currency),
        value: currency,
      ));
    }

    return currencyList;
  }

  String selectedCurrency = 'USD';

  Price getPrice = Price();
  double btc_price = 0;
  double eth_price = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('🤑 Coin Ticker'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $btc_price $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 Eth = $eth_price $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: CupertinoPicker(
              itemExtent: 32,
              onSelectedItemChanged: (value) async {
                selectedCurrency = currenciesList[value];

                double btc_updated =
                    await getPrice.getCoinPrice('BTC', selectedCurrency);

                double eth_updated =
                    await getPrice.getCoinPrice('ETH', selectedCurrency);

                setState(() {
                  btc_price = btc_updated.truncateToDouble();
                  eth_price = eth_updated;
                });
              },
              children: getCurrencyList(),
            ),
          ),
        ],
      ),
    );
  }
}
