import 'package:hive/hive.dart';
part 'category_model.g.dart';

@HiveType(typeId: 1)
enum CategoryType {
  @HiveField(0)
  income,
  @HiveField(1)
  expense,
}

@HiveType(typeId: 2)
class catogoryModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final bool isDeleted;
  @HiveField(3)
  final CategoryType type;

  catogoryModel({
    required this.id,
    required this.name,
    this.isDeleted = false,
    required this.type,
  });
  @override
  String toString() {
    return '{$name $type}';
  }
}
