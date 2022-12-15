import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';
import 'package:synctest/domain/databases/context_models/auth_connection.dart';
import 'package:synctest/infrastructure/idata_repository.dart';

class HomeViewModel extends BaseViewModel {
  final String _title = "Hello World";
  List<AuthConnection> _cards = [];
  GetIt getIt = GetIt.instance;
  String get title => _title;
  int _counter = 0;
  int get counter => _counter;
  List<AuthConnection> get cards => _cards;

  void initialise() async {
    var repository = getIt.get<IDataRepository>();
    _cards = await repository.getEnabledConnections();
    _cards.add(AuthConnection(
        222,
        DateTime.now(),
        "kristifor@collaborativesoft.com",
        true,
        "wdadwaddwa",
        "portal.azure.com"));
    notifyListeners();
  }

  void updateCounter() {
    _counter++;
    notifyListeners();
  }
}
