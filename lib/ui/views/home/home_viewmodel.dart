import 'package:stacked/stacked.dart';

import '../../../Components/ConnectionComponent.dart';
import '../../../Components/Shared/CardComponent.dart';

class HomeViewModel extends BaseViewModel {
  String _title = "Hello World";
  List<CardComponent> _cards = [];

  String get title => _title;
  int _counter = 0;
  int get counter => _counter;
  List<CardComponent> get cards => _cards;

  HomeViewModel() {
    _cards = [
      CardComponent(
          render: ConnectionComponent(
        url: "portal.azure.com",
        email: "kristifor@collaborativesoft.com",
        currentDate: "02/12/2022",
        IsMain: true,
      )),
      CardComponent(
          render: ConnectionComponent(
              url: "portal.azure.com",
              email: "kristifor@collaborativesoft.com",
              currentDate: "02/12/2022",
              IsMain: true)),
      CardComponent(
          render: ConnectionComponent(
              url: "portal.azure.com",
              email: "kristifor@collaborativesoft.com",
              currentDate: "02/12/2022",
              IsMain: true)),
      CardComponent(
          render: ConnectionComponent(
              url: "portal.azure.com",
              email: "kristifor@collaborativesoft.com",
              currentDate: "02/12/2022",
              IsMain: true)),
      CardComponent(
          render: ConnectionComponent(
              url: "portal.azure.com",
              email: "kristifor@collaborativesoft.com",
              currentDate: "02/12/2022",
              IsMain: true)),
    ];
  }

  void updateCounter() {
    _counter++;
    notifyListeners();
  }
}
