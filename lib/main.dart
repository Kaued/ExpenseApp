import 'dart:io';
import 'dart:math';

import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ExpenseApp());
}

class ExpenseApp extends StatelessWidget {
  ExpenseApp({super.key});
  final theme = ThemeData();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
      theme: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
            primary: Colors.purple,
            secondary: Colors.amber,
          ),
          textTheme: theme.textTheme.copyWith(
            titleLarge: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: "OpenSans",
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: "OpenSans",
              fontSize: 20,
            ),
          )),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transaction = [];
  final bool _showChart = false;

  List<Transaction> get _recentTransaction {
    return _transaction
        .where(
          (element) => element.date.isAfter(
            DateTime.now().subtract(
              const Duration(days: 7),
            ),
          ),
        )
        .toList();
  }

  void addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      date: date,
      value: value,
    );

    setState(() {
      _transaction.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _openTransactionModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(onSubmit: addTransaction);
      },
    );
  }

  _deleteTransaction(String id) {
    setState(() {
      _transaction.removeWhere((element) => id == element.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    Widget getIconButton(IconData icon, Function() fn) {
      return Platform.isIOS
          ? GestureDetector(
              onTap: fn,
              child: Icon(icon),
            )
          : IconButton(
              onPressed: fn,
              icon: Icon(icon),
              color: Colors.white,
            );
    }

    final iconList = Platform.isIOS ? CupertinoIcons.refresh : Icons.list;
    final iconChart =
        Platform.isIOS ? CupertinoIcons.refresh : Icons.show_chart;

    final actions = <Widget>[
      if (isLandscape)
        getIconButton(
            _showChart ? iconList : iconChart, () => _showChart == !_showChart),
      getIconButton(
        Platform.isIOS ? CupertinoIcons.add : Icons.add,
        () => _openTransactionModal(context),
      ),
    ];

    final appBar = AppBar(
      title: Text(
        "Despesas Pessoais",
        style: TextStyle(
          fontSize: mediaQuery.textScaler.scale(20),
        ),
      ),
      actions: actions,
      backgroundColor: Theme.of(context).colorScheme.primary,
    );

    final availableHeigh = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final bodyPage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_showChart || !isLandscape)
              SizedBox(
                width: double.infinity,
                height: availableHeigh * (isLandscape ? 0.7 : 0.3),
                child: Chart(
                  recentTransactions: _recentTransaction,
                ),
              ),
            if (!_showChart || !isLandscape)
              SizedBox(
                height: availableHeigh * 0.7,
                child: TransactionList(_transaction, _deleteTransaction),
              ),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: const Text("Despesas Pessoais"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: actions,
              ),
            ),
            child: bodyPage,
          )
        : Scaffold(
            appBar: appBar,
            body: bodyPage,
            floatingActionButton: FloatingActionButton(
              onPressed: () => _openTransactionModal(context),
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
