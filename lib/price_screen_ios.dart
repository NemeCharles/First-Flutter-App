import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';


const kFontStyle = TextStyle(
  fontSize: 20.0,
  color: Colors.white,
);


class PriceScreenIOS extends StatefulWidget {
  const PriceScreenIOS({Key? key}) : super(key: key);

  @override
  _PriceScreenIOSState createState() => _PriceScreenIOSState();
}

class _PriceScreenIOSState extends State<PriceScreenIOS> {

  String dropdownValue = currenciesList[19];
  String cryptoValue = cryptoList[0];
  Map<String, String> cryptoPrice = {};


  // One way of creating a dropdown menu.
  // call the function menu() down below inside the items parameter in dropdownbutton

  //  List<DropdownMenuItem<String>> menu () {
  //
  //    List<DropdownMenuItem<String>> dropdownItems = [];
  //
  //   for(String currency in currenciesList) {
  //     var menuItem = DropdownMenuItem(
  //       child: Text(currency),
  //       value: currency,
  //     );
  //     dropdownItems.add(menuItem);
  //   }
  //
  //   return dropdownItems;
  // }

  CupertinoPicker iosPicker () {
    List<Text> listItem = [];
    for (String currency in currenciesList) {
      var currencyMenu = Text(currency,
        style: const TextStyle(
            color: Colors.white
        ),
      );
      listItem.add(currencyMenu);
    }
    return CupertinoPicker(
        backgroundColor: Colors.tealAccent[700],
        itemExtent: 32.0,
        onSelectedItemChanged: (index) {
          dropdownValue = currenciesList[index];
          updateScreen();
        },
        children: listItem
    );
  }

  void updateScreen() async {
    var data = await CoinDataIOS().getData(dropdownValue);
    setState(() {
      if(data != null) {
        cryptoPrice = data;

      }else{cryptoPrice = {};}
    });
  }

  @override
  void initState() {
    super.initState();
    updateScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PriceCard(
                coinName: 'BTC',
                selectedCurrency: dropdownValue,
                cryptoPrice: cryptoPrice.isEmpty ? '0' : cryptoPrice['BTC']
              ),
              PriceCard(
                  coinName: 'ETH',
                  selectedCurrency: dropdownValue,
                  cryptoPrice: cryptoPrice.isEmpty ? '0' : cryptoPrice['ETH']
              ),
              PriceCard(
                  coinName: 'LTC',
                  selectedCurrency: dropdownValue,
                  cryptoPrice: cryptoPrice.isEmpty ? '0' : cryptoPrice['LTC']
              ),
              PriceCard(
                  coinName: 'ADA',
                  selectedCurrency: dropdownValue,
                  cryptoPrice: cryptoPrice.isEmpty ? '0' : cryptoPrice['ADA']
              )
            ],
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(bottom: 30.0),
              color: Colors.tealAccent[700],
              child: Row(
                children: [
                  Expanded(child: iosPicker())
                ],
              )
          ),
        ],
      ),
    );
  }
}

class PriceCard extends StatelessWidget {
  const PriceCard({
    Key? key,
    required this.cryptoPrice, required this.coinName, required this.selectedCurrency,
  }) : super(key: key);

  final String? cryptoPrice;
  final String coinName;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
      child: Card(
        color: Colors.tealAccent[700],
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 9.0, horizontal: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('1 $coinName  = $cryptoPrice $selectedCurrency',
                  style: kFontStyle
                )
              ],
            )
        ),
      ),
    );
  }
}
