import 'package:flutter/material.dart';

class BottomMenu extends StatefulWidget {
  const BottomMenu({Key? key}) : super(key: key);

  @override
  State<BottomMenu> createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  String? _selectedCurrency = 'USD';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedCurrency,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
      dropdownColor: Theme.of(context).colorScheme.background,
      items: [
        DropdownMenuItem(
          child: Text('USD'),
          value: 'USD',
        ),
        DropdownMenuItem(
          child: Text('EUR'),
          value: 'EUR',
        ),
        DropdownMenuItem(
          child: Text('RUB'),
          value: 'RUB',
        ),
      ],
      onChanged: (value) {
        setState(() {
          _selectedCurrency = value;
        });
      },
    );
  }
}
