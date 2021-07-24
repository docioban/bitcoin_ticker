import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String currentValut = "USD";
  var result = new Map();

  Widget createDropDownMenu() {
    List<DropdownMenuItem<String>> listElem = [];

    for (String currencie in currenciesList) {
      listElem.add(
        DropdownMenuItem<String>(
          value: currencie,
          child: Text(
            currencie,
          ),
        ),
      );
    }
    return DropdownButton(
      items: listElem,
      value: currentValut,
      onChanged: (value) async {
        currentValut = currenciesList[value];
        for (String crypto in cryptoList) {
          setState(() {
            result[crypto] = '?';
          });
        }
        for (String crypto in cryptoList) {
          updateUI(await CoinData().getExchange(crypto, currenciesList[value]));
        }
      },
    );
  }

  Widget createPicker() {
    List<Widget> listElem = [];

    for (String currencie in currenciesList) {
      listElem.add(Text(currencie));
    }
    return CupertinoPicker(
      children: listElem,
      itemExtent: 30,
      onSelectedItemChanged: (int value) async {
        currentValut = currenciesList[value];
        for (String crypto in cryptoList) {
          setState(() {
            result[crypto] = '?';
          });
        }
        for (String crypto in cryptoList) {
          updateUI(await CoinData().getExchange(crypto, currenciesList[value]));
        }

      },
    );
  }

  void updateUI(dynamic data) {
    setState(() {
      if (data == null) {
        result = new Map();
        return;
      } else {
        double rate = data['rate'];
        result[data['asset_id_base']] = rate.toStringAsFixed(2);
      }
    });
  }

  Column getCourse() {
    List<Card> list = [];
    for (String crypto in cryptoList) {
      list.add(
        Card(
          color: Colors.lightBlueAccent,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
            child: Text(
              '1 $crypto = ${result[crypto]} $currentValut',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    }

    return Column(
      children: list,
    );
  }

  @override
  void initState() {
    super.initState();
    setPage();
  }

  void setPage() async {
    for (String crypto in cryptoList) {
      updateUI(await CoinData().getExchange(crypto, currentValut));
    }
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
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: getCourse(),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? createPicker() : createDropDownMenu(),
          ),
        ],
      ),
    );
  }
}
