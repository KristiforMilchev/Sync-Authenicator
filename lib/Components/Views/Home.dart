import 'package:flutter/material.dart';
import '/Components/Shared/CardComponent.dart';
import '/Components/ConnectionComponent.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(30,30,38, 1),
      child: ListView(

        children: [
          CardComponent(render: ConnectionComponent(url: "portal.azure.com", email: "kristifor@collaborativesoft.com", currentDate: "02/12/2022")),
          CardComponent(render: ConnectionComponent(url: "portal.azure.com", email: "kristifor@collaborativesoft.com", currentDate: "02/12/2022")),
          CardComponent(render: ConnectionComponent(url: "portal.azure.com", email: "kristifor@collaborativesoft.com", currentDate: "02/12/2022")),
          CardComponent(render: ConnectionComponent(url: "portal.azure.com", email: "kristifor@collaborativesoft.com", currentDate: "02/12/2022")),
          CardComponent(render: ConnectionComponent(url: "portal.azure.com", email: "kristifor@collaborativesoft.com", currentDate: "02/12/2022")),

        ],
      ),
    );
  }
}
