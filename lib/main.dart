import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pay_manager/db/catogory/category_db.dart';
import 'package:pay_manager/models/category/category_model.dart';
import 'package:pay_manager/models/transactions/transaction_model.dart';
import 'package:pay_manager/screens/home/home_pg.dart';
import 'package:pay_manager/screens/transaction_add.dart/transactionadd.dart';

Future<void> main() async {
  final obj1 = catogoryDB();
  final obj2 = catogoryDB();

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }
  if (!Hive.isAdapterRegistered(catogoryModelAdapter().typeId)) {
    Hive.registerAdapter(catogoryModelAdapter());
  }
  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Money Manager  ',
      theme: ThemeData(primarySwatch: Colors.amber),
      home: screenhome(),
      routes: {
        screenaddtransaction.routeName: (ctx) => screenaddtransaction(),
      },
    );
  }
}
