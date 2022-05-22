import 'package:flutter/material.dart';
import 'bottom_menu.dart';
import 'networking.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String _exchangeRate = '1 BTC = ? USD';

  @override
  void initState() {
    super.initState();
    updateExchangeRate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Bitcoin ticker'),
      ),
      body: Container(
        alignment: AlignmentDirectional.center,
        child: Card(
          color: Theme.of(context).colorScheme.primary,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              _exchangeRate,
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
          child: BottomMenu(),
        ),
      ),
    );
  }

  void updateExchangeRate() async {
    _exchangeRate = await getExchangeRate();
    setState(() {});
  }
}
