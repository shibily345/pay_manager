import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:pay_manager/db/transaction/transaction_db.dart';
import 'package:pay_manager/models/category/category_model.dart';
import 'package:pay_manager/models/transactions/transaction_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../db/catogory/category_db.dart';

class transacpg extends StatelessWidget {
  const transacpg({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();
    catogoryDB().refreshUI();
    return ValueListenableBuilder(
        valueListenable: TransactionDB.instance.transactionlistNotifier,
        builder: (BuildContext ctx, List<TransactionModel> newList, Widget? _) {
          return ListView.separated(
            padding: const EdgeInsets.all(10),
            itemBuilder: (ctx, index) {
              final _value = newList[index];
              return Slidable(
                key: Key(_value.id!),
                startActionPane: ActionPane(
                  motion: DrawerMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (ctx) {
                        TransactionDB.instance.deletTransaction(_value.id!);
                      },
                      icon: IconlyBroken.delete,
                      backgroundColor: Color.fromARGB(255, 57, 56, 56),
                      foregroundColor: Color.fromARGB(255, 255, 0, 0),
                      label: 'Delete',
                    )
                  ],
                ),
                child: Card(
                  color: Color.fromARGB(255, 255, 243, 198),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color.fromARGB(0, 0, 0, 0),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  elevation: 3,
                  child: Center(
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 50,
                        child: Text(
                          parsDate(_value.date),
                          textAlign: TextAlign.center,
                        ),
                        backgroundColor: _value.type == CategoryType.income
                            ? Color.fromARGB(255, 26, 120, 0)
                            : Color.fromARGB(255, 255, 0, 0),
                      ),
                      title: Text('Rs ${_value.amount}'),
                      subtitle: Text('${_value.purpous}'),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (ctx, index) {
              return const SizedBox(
                height: 10,
              );
            },
            itemCount: newList.length,
          );
        });
  }

  String parsDate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final _splitedDate = _date.split(' ');
    return '${_splitedDate.last}\n${_splitedDate.first}';
  }
}
