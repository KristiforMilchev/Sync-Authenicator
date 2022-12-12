import 'package:hive/hive.dart';

abstract class IDatabaseContext<T> {
  Future<Box> create(String database);

  Box getBox();
}
