import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';
import 'package:synctest/domain/databases/context_models/auth_connection.dart';
import 'package:synctest/infrastructure/iauthentication.dart';
import 'package:synctest/infrastructure/idata_repository.dart';
import 'package:synctest/infrastructure/ipage_router_service.dart';

class RemoveConnectionModalViewModel extends BaseViewModel {
  GetIt getIt = GetIt.instance;
  late IDataRepository _repository;
  late IPageRouterService _pageRouterService;
  late IAuthentication _authentication;

  initialized() {
    _repository = getIt.get<IDataRepository>();
    _pageRouterService = getIt.get<IPageRouterService>();
    _authentication = getIt.get<IAuthentication>();
  }

  removeItem(String url, String email) async {
    var connection = await _repository.getConnectionsByEmailUrl(email, url);

    if (connection != null) {
      _repository.removeConnection(connection.id);
      _authentication.connectionRemoved(connection);
      _pageRouterService.dismissActionDialog("removeBox");
    }
  }
}
