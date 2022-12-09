import 'package:stacked/stacked.dart';

class HistoryViewModel extends BaseViewModel {
  //seters
  String? _selectedProvider = "One";
  List<String> _providers = <String>['One', 'Two', 'Three', 'Four'];

  String? get selectedProvider => _selectedProvider;
  get providers => _providers;

  void dropdownValueChanged(String? value) {
    _selectedProvider = value;
    notifyListeners();
  }
}
