import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'data.dart';
import 'networking.dart';
import 'dart:io' show Platform;

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String _selectedCurrency = 'USD';
  final List<String> _exchangeRates = List.filled(cryptoCurrencies.length, '?');

  @override
  void initState() {
    super.initState();
    updateExchangeRate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Bitcoin ticker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: cryptoCurrencyCards(),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 75.0,
          alignment: Alignment.center,
          color: Theme.of(context).colorScheme.secondary,
          child: bottomMenu(),
        ),
      ),
    );
  }

  //region Crypto Currency Cards
  List<Widget> cryptoCurrencyCards() {
    List<Widget> items = [];
    for (int i = 0; i < cryptoCurrencies.length; i++) {
      Card newCard = Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Theme.of(context).colorScheme.primary,
        shadowColor: Colors.white10,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            '1 ${cryptoCurrencies[i]} = ${_exchangeRates[i]} $_selectedCurrency',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
            textAlign: TextAlign.center,
          ),
        ),
      );

      items.add(newCard);
    }

    return items;
  }

  //endregion

  //region Bottom Menu
  Widget bottomMenu() {
    if (Platform.isIOS) {
      return iOSCurrencyPicker();
    } else {
      return androidCurrencyPicker();
    }
  }

  DropdownButton<String> androidCurrencyPicker() {
    return DropdownButton<String>(
      value: _selectedCurrency,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
      dropdownColor: Theme.of(context).colorScheme.background,
      items: getAndroidCurrenciesList(),
      onChanged: (value) {
        setState(() {
          _selectedCurrency = value!;
          updateExchangeRate();
        });
      },
    );
  }

  CupertinoPicker iOSCurrencyPicker() {
    return CupertinoPicker(
      itemExtent: 30.0,
      onSelectedItemChanged: (value) {
        setState(() {
          _selectedCurrency = sellingCurrencies[value];
          updateExchangeRate();
        });
      },
      children: getIOSCurrenciesList(),
    );
  }

  List<DropdownMenuItem<String>> getAndroidCurrenciesList() {
    List<DropdownMenuItem<String>> menuItems = [];

    for (String item in sellingCurrencies) {
      DropdownMenuItem<String> newItem = DropdownMenuItem(
        child: Text(item),
        value: item,
      );

      menuItems.add(newItem);
    }

    return menuItems;
  }

  List<Text> getIOSCurrenciesList() {
    List<Text> menuItems = [];

    for (String currencyName in sellingCurrencies) {
      Text newItem = Text(
        currencyName,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      );
      menuItems.add(newItem);
    }

    return menuItems;
  }
  //endregion

  void updateExchangeRate() async {
    for (int i = 0; i < cryptoCurrencies.length; i++) {
      _exchangeRates[i] = '?';
    }

    for (int i = 0; i < cryptoCurrencies.length; i++) {
      _exchangeRates[i] =
          await getExchangeRate(cryptoCurrencies[i], _selectedCurrency);
    }
    setState(() {});
  }
}
