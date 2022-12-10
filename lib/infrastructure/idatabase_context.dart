import 'package:hive/hive.dart';

abstract class IDatabaseContext<T> {
  Future<Box> create();

  Box getBox();
}
