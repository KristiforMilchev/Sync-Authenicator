import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';

class SetupViewModel extends BaseViewModel {
  GetIt getIt = GetIt.instance;

  void initialise() async {
    notifyListeners();
  }
}
