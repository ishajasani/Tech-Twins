import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  final String name, address;
  final double amount;
  const TransactionTile({
    super.key,
    required this.name,
    required this.address,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(.1),
          borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        trailing: Text('-$amount Matic'),
        leading: CircleAvatar(
          radius: 20,
          child: Text(name[0]),
        ),
        title: Text(name),
        subtitle: Text(address),
      ),
    );
  }
}
