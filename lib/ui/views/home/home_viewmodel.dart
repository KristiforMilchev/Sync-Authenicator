import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  String _title = "Hello World";

  String get title => _title;
  int _counter = 0;
  int get counter => _counter;

  void updateCounter() {
    _counter++;
    notifyListeners();
  }
}
