import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;


const apiKey = 'B6383058-A208-4C38-8550-4E103F912B40';
const kFontStyle = TextStyle(
  fontSize: 20.0,
  color: Colors.white,
);


class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  String dropdownValue = currenciesList[19];
  String cryptoValue = cryptoList[0];
  String cryptoPrice = '0';


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

  DropdownButton<String> dropdownMenu() {
    return DropdownButton<String>(
        value: dropdownValue,
        items: currenciesList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value,
              style: kFontStyle,
            ),
          );
        }).toList(),
        onChanged: (String? value) {
          setState(() {
            dropdownValue = value!;
            updateScreen();
          });
        });
  }

  DropdownButton<String> dropdownMenuOne() {
    return DropdownButton<String>(
        value: cryptoValue,
        items: cryptoList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value,
              style: kFontStyle,
            ),
          );
        }).toList(),
        onChanged: (String? value) {
          setState(() {
            cryptoValue = value!;
            updateScreen();
          });
        });
  }

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
        itemExtent: 36.0,
        onSelectedItemChanged: (index) {
          dropdownValue = currenciesList[index];
          updateScreen();
        },
        children: listItem
    );
  }

  void updateScreen() async {
    var data = await CoinData().getData('https://rest.coinapi.io/v1/exchangerate/$cryptoValue/$dropdownValue?apikey=$apiKey');
    setState(() {
      if(data != null) {
        var price = data;
        cryptoPrice = price.toStringAsFixed(2);
      }else{cryptoPrice = '0';}
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
              Card(
                 color: Colors.tealAccent[700],
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 9.0, horizontal: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('1',
                        style: kFontStyle,
                      ),
                      dropdownMenuOne()
                    ],
                  )
                ),
              ),
              Card(
                color: Colors.tealAccent[700],
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 9.0, horizontal: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(cryptoPrice,
                        style: kFontStyle,
                      ),
                      dropdownMenu()
                    ],
                  )
                ),
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.tealAccent[700],
            child: Row(
              children: [
                Platform.isIOS ? iosPicker(): dropdownMenu()
              ],
            )
          ),
        ],
      ),
    );
  }
}
