import 'package:flutter/material.dart';
import 'package:synctest/Assets/styles.dart';
import '/Components/Shared/CardComponent.dart';
import '/Components/ConnectionComponent.dart';

List<ConnectionComponent> connectionComponentList = [
  const ConnectionComponent(
    url: "portal.azure.com",
    email: "kristifor@collaborativesoft.com",
    currentDate: "02/12/2022",
    IsMain: true,
  ),
  const ConnectionComponent(
    url: "portal.azure.com",
    email: "kristifor@collaborativesoft.com",
    currentDate: "02/12/2022",
    IsMain: true,
  ),
  const ConnectionComponent(
    url: "portal.azure.com",
    email: "kristifor@collaborativesoft.com",
    currentDate: "02/12/2022",
    IsMain: true,
  ),
  const ConnectionComponent(
    url: "portal.azure.com",
    email: "kristifor@collaborativesoft.com",
    currentDate: "02/12/2022",
    IsMain: true,
  ),
  const ConnectionComponent(
    url: "portal.azure.com",
    email: "kristifor@collaborativesoft.com",
    currentDate: "02/12/2022",
    IsMain: true,
  ),
];

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(30, 30, 38, 1),
        body: connectionComponentList.isEmpty
            ? Center(
                child: Text(
                  'No link added ',
                  style: TextStyle(color: ThemeColors.mainText),
                ),
              )
            : ListView.builder(
                itemCount: connectionComponentList.length,
                itemBuilder: (context, index) {
                  return CardComponent(render: connectionComponentList[index]);
                }));
  }
}
