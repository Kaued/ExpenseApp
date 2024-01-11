import 'package:expenses/components/transaction_item.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final void Function(String) _onDelete;

  const TransactionList(this._transactions, this._onDelete, {super.key});

  @override
  Widget build(BuildContext context) {
    return _transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraint) {
              return Column(
                children: [
                  Text(
                    "Nenhuma Transação Cadastrada",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: constraint.maxHeight * 0.6,
                    child: Image.asset(
                      "assets/images/waiting.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: _transactions.length,
            itemBuilder: (ctx, index) {
              final e = _transactions[index];

              return TransactionItem(e: e, onDelete: _onDelete);
            },
          );
  }
}
