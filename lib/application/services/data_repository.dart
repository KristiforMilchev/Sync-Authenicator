import 'dart:html';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:synctest/domain/databases/context_models/auth_connection.dart';
import 'package:synctest/domain/databases/context_models/connection_attempt.dart';

import 'package:synctest/infrastructure/idata_repository.dart';

class DataRepository implements IDataRepository {
  DataRepository(this.box) {
    //print(box.get(1));
  }

  Box box;

  @override
  void ensureCreated(String type) async {
    await Hive.initFlutter();
    var currentBox = await Hive.openBox(type);
    box = currentBox;
  }

  @override
  bool addConnection(AuthConnection connection) {
    ensureCreated("AuthConnection");
    var lastKey = box.keys.last as int;
    box.add(connection);
    return true;
  }

  @override
  List<AuthConnection> getAllConnections() {
    ensureCreated("AuthConnection");
    return box.values.toList() as List<AuthConnection>;
  }

  @override
  AuthConnection getConnectionsById(int id) {
    ensureCreated("AuthConnection");
    var connections = box.values.toList() as List<AuthConnection>;
    return connections.firstWhere((element) => element.id == id);
  }

  @override
  List<AuthConnection> getEnabledConnections() {
    ensureCreated("AuthConnection");
    var connections = box.values.toList() as List<AuthConnection>;
    return connections.where((element) => element.isEnabled).toList();
  }

  @override
  Future<bool> removeConnection(int id) async {
    ensureCreated("AuthConnection");
    await box.delete(id);
    return true;
  }

  @override
  List<ConnectionAttempt> getConnectionAttemptsByAuthId(int id) {
    ensureCreated("ConnectionAttempt");
    var attempts = box.values.toList() as List<ConnectionAttempt>;
    return attempts.where((element) => element.authConnectionId == id).toList();
  }

  @override
  bool addConnectionAttempt(ConnectionAttempt connection) {
    ensureCreated("ConnectionAttempt");
    var lastKey = box.keys.last as int;
    box.add(connection);
    return true;
  }
}
