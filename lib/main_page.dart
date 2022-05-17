import 'package:flutter/material.dart';
import 'bottom_menu.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

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
              '1 BTC = ? USD',
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
}
