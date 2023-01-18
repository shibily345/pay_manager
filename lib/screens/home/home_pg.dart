import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:pay_manager/screens/category/cat_add_popup.dart';

import 'package:pay_manager/screens/category/catogory_pg.dart';
import 'package:pay_manager/screens/home/bottombar.dart';
import 'package:pay_manager/screens/transaction/screen_transaction.dart';
import 'package:pay_manager/screens/transaction_add.dart/transactionadd.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

class screenhome extends StatelessWidget {
  screenhome({super.key});
  static ValueNotifier<int> selectedindexNotifier = ValueNotifier(0);
  final _pages = const [
    transacpg(),
    screenCatogory(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 57, 56, 56),
      appBar: AppBar(
        title: Text('PayManager'),
        leading: Icon(IconlyBroken.wallet),
      ),
      bottomNavigationBar: bottomnavMM(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedindexNotifier,
          builder: (BuildContext context, int updatedindex, _) {
            return _pages[updatedindex];
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedindexNotifier.value == 0) {
            print('Transaction');
            Navigator.of(context).pushNamed(screenaddtransaction.routeName);
          } else {
            print('Catogory ');
            showcatogoryAddpopup(context);
          }
        },
        child: Icon(IconlyBroken.paper_plus),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
