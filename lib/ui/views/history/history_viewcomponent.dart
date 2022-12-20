import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';
import 'package:synctest/domain/databases/context_models/auth_connection.dart';
import 'package:synctest/domain/databases/context_models/connection_attempt.dart';
import 'package:synctest/infrastructure/iauthentication.dart';
import 'package:synctest/infrastructure/idata_repository.dart';

class HistoryViewModel extends BaseViewModel {
  //Dependecy Injections
  GetIt getIt = GetIt.instance;
  IDataRepository? _repository;
  late IAuthentication _authentication;

  //seters
  List<AuthConnection> _providers = [];
  List<ConnectionAttempt> _connectionAttempts = [];
  AuthConnection? _selectedProvider;

  //Getters
  AuthConnection? get selectedProvider => _selectedProvider;
  List<AuthConnection> get providers => _providers;
  List<ConnectionAttempt> get connectionAttempts => _connectionAttempts;

  initialise() async {
    _authentication = getIt.get<IAuthentication>();

    _repository = getIt.get<IDataRepository>();
    _providers = await _repository!.getEnabledConnections();
    if (_providers.isNotEmpty) {
      _selectedProvider = _providers.first;
      dropdownValueChanged(_providers.first);
    }
    _authentication.bindHistoryModel(this);
    notifyListeners();
  }

  void dropdownValueChanged(AuthConnection? value) async {
    _selectedProvider = value;
    _connectionAttempts =
        await _repository!.getConnectionAttemptsByAuthId(value!.id);
    notifyListeners();
  }

  void connectionAttemptAdded(int parentId, ConnectionAttempt newAttempt) {
    if (_selectedProvider!.id == parentId) {
      _connectionAttempts.add(newAttempt);
      notifyListeners();
    }
  }
}
