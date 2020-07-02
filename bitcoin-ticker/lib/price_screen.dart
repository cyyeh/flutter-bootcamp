import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bitcoin_ticker/coin_data.dart';
import 'package:bitcoin_ticker/price_card.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  Map<String, int> coinPricesMap = {};
  CoinData coinData = CoinData();

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];

    for (String currency in currenciesList) {
      dropdownItems.add(DropdownMenuItem(
        child: Text(currency),
        value: currency,
      ));
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        selectedCurrency = value;
        getCoinData(selectedCurrency);
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];

    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        selectedCurrency = currenciesList[selectedIndex];
        getCoinData(selectedCurrency);
      },
      children: pickerItems,
    );
  }

  List<Widget> getCoinPriceCards() {
    List<Widget> priceCards = [];

    for (String crypto in cryptoList) {
      priceCards.add(
        CoinPriceCard(
            cryptoRate: coinPricesMap[crypto],
            crypto: crypto,
            selectedCurrency: selectedCurrency),
      );
    }

    return priceCards;
  }

  void getCoinData(String currency) async {
    var newCoinPrices = await coinData.getCoinData(currency);
    updateUI(newCoinPrices);
  }

  void updateUI(newCoinPrices) {
    setState(() {
      coinPricesMap = newCoinPrices;
    });
  }

  void initializeCoinPricesMap() {
    for (String crypto in cryptoList) {
      coinPricesMap[crypto] = null;
    }
  }

  @override
  void initState() {
    super.initState();
    initializeCoinPricesMap();

    getCoinData(selectedCurrency);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: getCoinPriceCards(),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
