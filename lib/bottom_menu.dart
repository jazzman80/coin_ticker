import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'data.dart';
import 'dart:io' show Platform;
import 'main_page.dart';

class BottomMenu extends StatefulWidget {
  BottomMenu({Key? key, required this.mainPage}) : super(key: key);
  MainPage mainPage;

  @override
  State<BottomMenu> createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  String? _selectedCurrency = 'USD';

  @override
  Widget build(BuildContext context) {
    /*if (Platform.isIOS) {
      return androidCurrencyPicker();
    } else {
      return iOSCurrencyPicker();
    }*/
    return androidCurrencyPicker();
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
          _selectedCurrency = value;
        });
      },
    );
  }

  CupertinoPicker iOSCurrencyPicker() {
    return CupertinoPicker(
      itemExtent: 30.0,
      onSelectedItemChanged: (value) {
        setState(() {
          _selectedCurrency = value.toString();
        });
      },
      children: getIOSCurrenciesList(),
    );
  }

  List<DropdownMenuItem<String>> getAndroidCurrenciesList() {
    List<DropdownMenuItem<String>> menuItems = [];

    for (String item in currenciesList) {
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

    for (String currencyName in currenciesList) {
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

  String? getSelectedCurrency() {
    return _selectedCurrency;
  }
}
