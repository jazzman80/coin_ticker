import 'package:flutter/material.dart';
import 'data.dart';

class BottomMenu extends StatefulWidget {
  const BottomMenu({Key? key}) : super(key: key);

  @override
  State<BottomMenu> createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  String? _selectedCurrency = 'USD';

  List<DropdownMenuItem<String>> getCurrenciesList() {
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

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedCurrency,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
      dropdownColor: Theme.of(context).colorScheme.background,
      items: getCurrenciesList(),
      onChanged: (value) {
        setState(() {
          _selectedCurrency = value;
        });
      },
    );
  }
}
