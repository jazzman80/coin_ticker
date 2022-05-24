import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'data.dart';
import 'networking.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String? _selectedCurrency = 'USD';
  String _exchangeRate = '?';

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
      body: Container(
        alignment: AlignmentDirectional.center,
        child: Card(
          color: Theme.of(context).colorScheme.primary,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              '1 BTC = $_exchangeRate $_selectedCurrency',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 150.0,
          alignment: Alignment.center,
          color: Theme.of(context).colorScheme.primary,
          child: bottomMenu(),
        ),
      ),
    );
  }

  Widget bottomMenu() {
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
          _selectedCurrency = currenciesList[value];
          updateExchangeRate();
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

  void updateExchangeRate() async {
    _exchangeRate = '?';
    _exchangeRate = await getExchangeRate(_selectedCurrency!);
    setState(() {});
  }
}
