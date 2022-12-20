import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:synctest/application/services/data_repository.dart';
import 'package:synctest/domain/databases/context_models/auth_connection.dart';
import 'package:synctest/domain/databases/context_models/connection_attempt.dart';
import 'package:synctest/domain/databases/database_context.dart';
import 'package:synctest/infrastructure/idata_repository.dart';
import 'package:synctest/infrastructure/idatabase_context.dart';

void main() {
  late final IDataRepository repository;
  var getIt = GetIt.instance;
  getIt.registerSingleton<IDatabaseContext>(DatabaseContext());
  getIt.registerSingleton<IDataRepository>(DataRepository("sync-auth-debug"));
  repository = getIt.get<IDataRepository>();

  group('DataRepositoryTests -', () {
    test("AddAuthConnection", () async {
      var authConnection1 = AuthConnection(
          999991, DateTime.now(), "test", true, "dwad", "wdadaw");
      var authConnection2 = AuthConnection(
          999992, DateTime.now(), "test", false, "dwad", "wdadaw");
      var authConnection3 = AuthConnection(
          999993, DateTime.now(), "test", true, "dwad", "wdadaw");

      var createFirst1 = await repository.addConnection(authConnection1);
      var createFirst2 = await repository.addConnection(authConnection2);
      var createFirst3 = await repository.addConnection(authConnection3);

      expect(createFirst1, true,
          reason: "Failed to create authConnection test 1");
      expect(createFirst2, true,
          reason: "Failed to create authConnection test 2");
      expect(createFirst3, true,
          reason: "Failed to create authConnection test 3");
    });

    test("AddConnectionAttempt", () async {
      var connectionAttemp1 =
          ConnectionAttempt(999991, DateTime.now(), 222, "dwad", "teata");
      var connectionAttemp2 =
          ConnectionAttempt(999991, DateTime.now(), 223, "dwad", "teata");
      var createFirst1 =
          await repository.addConnectionAttempt(connectionAttemp1);
      var createFirst2 =
          await repository.addConnectionAttempt(connectionAttemp2);

      expect(createFirst1, true,
          reason: "Failed to create Connection Attempt test 1");
      expect(createFirst2, true,
          reason: "Failed to create Connection Attempt test 2");
    });

    test("GetEnabledConnections", (() async {
      var enabledConnections = await repository.getEnabledConnections();

      expect(enabledConnections, isNot(null),
          reason: "Enabled connections are null, should be at least 1");
      var least = enabledConnections.isNotEmpty;
      expect(least, true,
          reason: "Expected least 1 enabled connection, foud 0");
    }));

    test("GetAllConnections", () async {
      var connections = await repository.getAllConnections();

      expect(connections, isNot(null),
          reason: "Connections are null, should return least 1 connections");
      var least = connections.isNotEmpty;

      expect(least, true,
          reason: "Expected least 1 enabled connection, foud 0");
    });

    test("GetConnectionAttemptsByAuthId", () async {
      var connections = await repository.getConnectionAttemptsByAuthId(999991);

      expect(connections, isNot(null),
          reason:
              "Connection attempts by auth Id are null, should be at least 1");
      var least = connections.isNotEmpty;
      expect(least, true,
          reason: "Expected least 1 enabled connection, foud 0");
    });

    test("RemoveConnectionAttempts", () async {
      var connectionAttempt1 = await repository.removeConnectionAttempt(222);
      var connectionAttempt2 = await repository.removeConnectionAttempt(223);

      expect(connectionAttempt1, true,
          reason: "Failed to delete connection attempt test 1 by id");

      expect(connectionAttempt2, true,
          reason: "Failed to delete connection attempt test 2 by id");
    });

    test("RemoveAuthConnection", () async {
      var addAuthConnection1 =
          AuthConnection(2222, DateTime.now(), "test", true, "dwad", "wdadaw");
      var addAauthConnection2 =
          AuthConnection(2223, DateTime.now(), "test", false, "dwad", "wdadaw");
      var addAauthConnection3 =
          AuthConnection(2224, DateTime.now(), "test", true, "dwad", "wdadaw");

      await repository.addConnection(addAuthConnection1);
      await repository.addConnection(addAauthConnection2);
      await repository.addConnection(addAauthConnection3);

      var authConnection1 = await repository.removeConnection(2222);
      var authConnection2 = await repository.removeConnection(2223);
      var authConnection3 = await repository.removeConnection(2224);

      expect(authConnection1, true,
          reason: "Failed to delete auth connetion test 1 by id");
      expect(authConnection2, true,
          reason: "Failed to delete auth connetion test 1 by id");
      expect(authConnection3, true,
          reason: "Failed to delete auth connetion test 1 by id");
    });

    test("RemoveNonExistantAuthConnection", () async {
      var result = await repository.removeConnection(87988989);

      expect(result, false,
          reason: "AuthConnection that doesn't exist should return false");
    });
    test("RemoveNonExistantConnectionAttempt", () async {
      var result = await repository.removeConnection(87988989);

      expect(result, false,
          reason: "Connection Attempt that doesn't exist should return false");
    });

    test("CleanTestDynamicData", () async {
      await repository.removeConnection(2222);
      await repository.removeConnection(2223);
      await repository.removeConnection(2224);
      await repository.removeConnectionAttempt(222);
      await repository.removeConnectionAttempt(222);
      await repository.removeConnectionAttempt(999991);
      await repository.removeConnectionAttempt(999992);
      await repository.removeConnection(999991);
      await repository.removeConnection(999992);
      await repository.removeConnection(999993);
    });
  });
}
