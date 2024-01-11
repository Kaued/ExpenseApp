import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    super.key,
    required this.e,
    required void Function(String p1) onDelete,
  }) : _onDelete = onDelete;

  final Transaction e;
  final void Function(String p1) _onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(
              child: Text(
                "R\$${e.value}",
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          e.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(
          DateFormat("d MMM y").format(e.date),
        ),
        trailing: MediaQuery.of(context).size.width < 600
            ? IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).colorScheme.error,
                onPressed: () {
                  return _onDelete(e.id);
                },
              )
            : TextButton.icon(
                onPressed: () {
                  return _onDelete(e.id);
                },
                icon: const Icon(Icons.delete),
                label: const Text("Excluir"),
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.error,
                ),
              ),
      ),
    );
  }
}
