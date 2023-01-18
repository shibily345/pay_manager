import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:pay_manager/db/catogory/category_db.dart';

import '../../models/category/category_model.dart';

class ExpenseCatogory extends StatelessWidget {
  const ExpenseCatogory({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: catogoryDB().expensecategorylist,
      builder: (BuildContext ctx, List<catogoryModel> newlist, Widget? _) {
        return ListView.separated(
          itemBuilder: (context, index) {
            final _category = newlist[index];
            return Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Card(
                elevation: 4,
                color: Color.fromARGB(255, 255, 255, 255),
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Color.fromARGB(0, 0, 0, 0),
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(12))),
                child: SizedBox(
                  height: 100,
                  child: Center(
                    child: ListTile(
                      hoverColor: Color.fromARGB(255, 168, 245, 255),
                      title: Text(_category.name),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: Icon(IconlyBold.delete),
                      ),
                    ),
                  ),
                ),
              ),
            );
            ;
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 5,
            );
          },
          itemCount: newlist.length,
        );
      },
    );
  }
}
