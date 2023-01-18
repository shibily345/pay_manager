import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pay_manager/db/catogory/category_db.dart';
import 'package:pay_manager/models/category/category_model.dart';

ValueNotifier<CategoryType> selectedCatogoryNotifier =
    ValueNotifier(CategoryType.income);
Future<void> showcatogoryAddpopup(BuildContext context) async {
  final _nameeditingController = TextEditingController();
  showDialog(
    context: context,
    builder: (ctx) {
      return SimpleDialog(
        backgroundColor: Color.fromARGB(255, 249, 255, 163),
        title: Text('Add Category'),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _nameeditingController,
              decoration: InputDecoration(
                hintText: 'Enter category',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                RadioButton(title: 'Income', type: CategoryType.income),
                RadioButton(title: 'Expence', type: CategoryType.expense)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton(
              onPressed: () {
                final _name = _nameeditingController.text.trim();
                if (_name.isEmpty) {
                  return;
                }
                final _type = selectedCatogoryNotifier.value;
                final _category = catogoryModel(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: _name,
                  type: _type,
                );
                catogoryDB.instance.insertCatogory(_category);
                Navigator.of(ctx).pop();
              },
              child: Text('Add'),
            ),
          ),
        ],
      );
    },
  );
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;

  RadioButton({
    super.key,
    required this.title,
    required this.type,
  });

  CategoryType? _type;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: selectedCatogoryNotifier,
          builder: (BuildContext ctx, CategoryType newCategory, Widget? _) {
            return Radio<CategoryType>(
                value: type,
                groupValue: newCategory,
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  selectedCatogoryNotifier.value = value;
                  selectedCatogoryNotifier.notifyListeners();
                });
          },
        ),
        Text(title)
      ],
    );
  }
}
