import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:pay_manager/db/catogory/category_db.dart';

import 'package:pay_manager/screens/category/expence.dart';
import 'package:pay_manager/screens/category/income.dart';

class screenCatogory extends StatefulWidget {
  const screenCatogory({super.key});

  @override
  State<screenCatogory> createState() => _screenCatogoryState();
}

class _screenCatogoryState extends State<screenCatogory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    catogoryDB().refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: Color.fromARGB(255, 255, 255, 255),
          unselectedLabelColor: Color.fromARGB(255, 0, 0, 0),
          tabs: [
            Tab(
              icon: Icon(IconlyBroken.arrow_down_circle),
              text: 'INCOME',
            ),
            Tab(
              icon: Icon(
                IconlyBroken.arrow_up_circle,
              ),
              text: 'EXPENSE',
            ),
          ],
        ),
        Expanded(
          child: TabBarView(controller: _tabController, children: [
            IncomeCatogory(),
            ExpenseCatogory(),
          ]),
        )
      ],
    );
  }
}
