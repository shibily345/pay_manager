import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:pay_manager/db/catogory/category_db.dart';
import 'package:pay_manager/db/transaction/transaction_db.dart';
import 'package:pay_manager/models/category/category_model.dart';
import 'package:pay_manager/models/transactions/transaction_model.dart';

class screenaddtransaction extends StatefulWidget {
  static const routeName = 'add_transaction';
  const screenaddtransaction({super.key});

  @override
  State<screenaddtransaction> createState() => _screenaddtransactionState();
}

class _screenaddtransactionState extends State<screenaddtransaction> {
  DateTime? _selectedDate;
  CategoryType? _selectedCategorytype;
  catogoryModel? _selectedCategorymodel;
  String? _categoryId;
  final _purpousTexteditingcontroller = TextEditingController();
  final _amountTexteditingcontroller = TextEditingController();
  @override
  void initState() {
    _selectedCategorytype = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 119, 119, 118),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                controller: _purpousTexteditingcontroller,
                decoration: InputDecoration(
                  hintText: 'Purpose',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _amountTexteditingcontroller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Amount',
                  border: OutlineInputBorder(),
                ),
              ),
              TextButton.icon(
                onPressed: () async {
                  final _selectedDatetemp = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(Duration(days: 30)),
                    lastDate: DateTime.now(),
                  );
                  if (_selectedDatetemp == null) {
                    return;
                  } else {
                    print(_selectedDatetemp.toString());
                    setState(() {
                      _selectedDate = _selectedDatetemp;
                    });
                  }
                },
                icon: Icon(IconlyBroken.calendar),
                label: Text(_selectedDate == null
                    ? 'Select Date'
                    : _selectedDate.toString()),
              ),
              Row(
                children: [
                  Radio(
                    value: CategoryType.income,
                    groupValue: _selectedCategorytype,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedCategorytype = CategoryType.income;
                        _categoryId = null;
                      });
                    },
                  ),
                  Text('income'),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: CategoryType.expense,
                    groupValue: _selectedCategorytype,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedCategorytype = CategoryType.expense;
                        _categoryId = null;
                      });
                    },
                  ),
                  Text('Expense '),
                ],
              ),
              DropdownButton(
                  iconEnabledColor: Colors.yellow,
                  hint: Text('Select Catogory '),
                  value: _categoryId,
                  // items: const [
                  //   DropdownMenuItem(
                  //     child: Text('Category 1'),
                  //     value: 1,
                  //   ),
                  //   DropdownMenuItem(
                  //     child: Text('Category 2'),
                  //     value: 2,
                  //   ),
                  //   DropdownMenuItem(
                  //     child: Text('Category 3'),
                  //     value: 3,
                  //   ),
                  // ],
                  items: (_selectedCategorytype == CategoryType.income
                          ? catogoryDB().incomecategorylist
                          : catogoryDB().expensecategorylist)
                      .value
                      .map((e) {
                    return DropdownMenuItem(
                      child: Text(e.name),
                      value: e.id,
                      onTap: () {
                        print(e.toString());
                        _selectedCategorymodel = e;
                      },
                    );
                  }).toList(),
                  onChanged: (selectedValue) {
                    print(selectedValue);
                    setState(() {
                      _categoryId = selectedValue;
                    });
                  }),
              ElevatedButton.icon(
                  onPressed: () {
                    addTRansaction();
                  },
                  icon: Icon(IconlyBroken.tick_square),
                  label: Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addTRansaction() async {
    final _purpousText = _purpousTexteditingcontroller.text;
    final _amountText = _amountTexteditingcontroller.text;
    if (_purpousText.isEmpty) {
      return;
    }
    if (_amountText.isEmpty) {
      return;
    }

    if (_selectedDate == null) {
      return;
    }
    final _parsedamount = double.tryParse(_amountText);
    if (_parsedamount == null) {
      return;
    }
    final _model = TransactionModel(
      purpous: _purpousText,
      amount: _parsedamount,
      date: _selectedDate!,
      type: _selectedCategorytype!,
    );
    await TransactionDB.instance.addTransaction(_model);
    Navigator.of(context).pop();
    TransactionDB.instance.refresh();
  }
}
