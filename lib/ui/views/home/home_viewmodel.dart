import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';
import 'package:synctest/domain/databases/context_models/auth_connection.dart';
import 'package:synctest/infrastructure/iauthentication.dart';
import 'package:synctest/infrastructure/idata_repository.dart';

class HomeViewModel extends BaseViewModel {
  List<AuthConnection> _cards = [];
  GetIt getIt = GetIt.instance;
  late IAuthentication _authentication;
  List<AuthConnection> get cards => _cards;

  void initialise() async {
    var repository = getIt.get<IDataRepository>();
    _cards = await repository.getEnabledConnections();
    _authentication = getIt.get<IAuthentication>();
    _authentication.bindHomeModels(this);
    notifyListeners();
  }

  void connectionApproved(AuthConnection getAuth) {
    _cards.firstWhere((element) => element.id == getAuth.id).createdAt =
        getAuth.createdAt;

    notifyListeners();
  }

  void addNewConnection(AuthConnection authConention) {
    _cards.add(authConention);
    notifyListeners();
  }

  void connectionRemoved(AuthConnection connection) {
    var getCard = _cards.firstWhere((element) => element.id == connection.id);
    _cards.remove(getCard);
    notifyListeners();
  }
}
