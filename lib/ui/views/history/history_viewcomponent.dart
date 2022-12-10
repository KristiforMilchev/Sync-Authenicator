import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';
import 'package:synctest/domain/databases/context_models/auth_connection.dart';
import 'package:synctest/domain/databases/context_models/connection_attempt.dart';
import 'package:synctest/infrastructure/idata_repository.dart';

class HistoryViewModel extends BaseViewModel {
  //Dependecy Injections
  GetIt getIt = GetIt.instance;
  IDataRepository? _repository;

  //seters
  List<AuthConnection> _providers = [];
  List<ConnectionAttempt> _connectionAttempts = [];
  AuthConnection? _selectedProvider;

  //Getters
  AuthConnection? get selectedProvider => _selectedProvider;
  get providers => _providers;
  List<ConnectionAttempt> get connectionAttempts => _connectionAttempts;

  void dropdownValueChanged(AuthConnection? value) async {
    _selectedProvider = value;
    _connectionAttempts =
        await _repository!.getConnectionAttemptsByAuthId(value!.id);
    notifyListeners();
  }

  initialise() async {
    _repository = getIt.get<IDataRepository>();
    _providers = await _repository!.getEnabledConnections();
    if (_providers.isNotEmpty) {
      _selectedProvider = _providers.first;
      dropdownValueChanged(_providers.first);
    }

    notifyListeners();
  }
}
