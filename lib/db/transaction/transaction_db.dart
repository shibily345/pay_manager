import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:pay_manager/models/transactions/transaction_model.dart';

const TRNSACTION_DB_NAME = 'transaction-db';

abstract class TransactionDbFungtions {
  Future<void> addTransaction(TransactionModel obj);
  Future<List<TransactionModel>> getallTransactions();
  Future<void> deletTransaction(String id);
}

class TransactionDB implements TransactionDbFungtions {
  TransactionDB._internal();
  static TransactionDB instance = TransactionDB._internal();
  factory TransactionDB() {
    return instance;
  }
  ValueNotifier<List<TransactionModel>> transactionlistNotifier =
      ValueNotifier([]);
  @override
  Future<void> addTransaction(TransactionModel obj) async {
    final _db = await Hive.openBox<TransactionModel>(TRNSACTION_DB_NAME);
    await _db.put(obj.id, obj);
  }

  Future<void> refresh() async {
    final _list = await getallTransactions();
    _list.sort((first, second) => second.date.compareTo(first.date));
    transactionlistNotifier.value.clear();
    transactionlistNotifier.value.addAll(_list);
    transactionlistNotifier.notifyListeners();
  }

  @override
  Future<List<TransactionModel>> getallTransactions() async {
    final _db = await Hive.openBox<TransactionModel>(TRNSACTION_DB_NAME);
    return _db.values.toList();
  }

  @override
  Future<void> deletTransaction(String id) async {
    final _db = await Hive.openBox<TransactionModel>(TRNSACTION_DB_NAME);
    await _db.delete(id);
    refresh();
  }
}
