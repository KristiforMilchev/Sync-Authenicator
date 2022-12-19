import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';
import 'package:synctest/infrastructure/idata_repository.dart';

class RemoveConnectionModalViewModel extends BaseViewModel {
  GetIt getIt = GetIt.instance;
  late IDataRepository _repository;

  initialized() {
    _repository = getIt.get<IDataRepository>();
  }

  removeItem(String url, String email) async {
    var connection = await _repository.getConnectionsByEmailUrl(email, url);

    if (connection != null) {
      _repository.removeConnection(connection!.id);
    }
  }
}
