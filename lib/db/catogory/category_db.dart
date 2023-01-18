import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:pay_manager/models/category/category_model.dart';

const CATEGORY_DB_NAME = 'category-database';

abstract class catogoryDBfungtions {
  Future<List<catogoryModel>> getCategories();
  Future<void> insertCatogory(catogoryModel value);
}

class catogoryDB implements catogoryDBfungtions {
  catogoryDB._internal();
  static catogoryDB instance = catogoryDB._internal();
  factory catogoryDB() {
    return instance;
  }
  ValueNotifier<List<catogoryModel>> incomecategorylist = ValueNotifier([]);
  ValueNotifier<List<catogoryModel>> expensecategorylist = ValueNotifier([]);
  @override
  Future<void> insertCatogory(catogoryModel value) async {
    final _catogoryDB = await Hive.openBox<catogoryModel>(CATEGORY_DB_NAME);
    await _catogoryDB.put(value.id, value);
    refreshUI();
  }

  @override
  Future<List<catogoryModel>> getCategories() async {
    final _catogoryDB = await Hive.openBox<catogoryModel>(CATEGORY_DB_NAME);
    return _catogoryDB.values.toList();
  }

  Future<void> refreshUI() async {
    final _allcatogories = await getCategories();
    incomecategorylist.value.clear();
    expensecategorylist.value.clear();
    await Future.forEach(
      _allcatogories,
      (catogoryModel category) {
        if (category.type == CategoryType.income) {
          incomecategorylist.value.add(category);
        } else {
          expensecategorylist.value.add(category);
        }
      },
    );
    incomecategorylist.notifyListeners();
    expensecategorylist.notifyListeners();
  }
}
