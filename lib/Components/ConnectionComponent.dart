import 'package:flutter/material.dart';


class ConnectionComponent extends StatelessWidget {

  String url;
  String email;
  String currentDate;

  ConnectionComponent({Key? key, required this.url,required this.email, required this.currentDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children:   [
        Container(margin: const EdgeInsets.fromLTRB(0, 5, 0, 0), child: Text(url, style: const TextStyle(color: Colors.white),)),
        Container(margin: const EdgeInsets.fromLTRB(0, 5, 0, 0), child: Text(email,  style: const TextStyle(color: Colors.white))),
        Container(margin: const EdgeInsets.fromLTRB(0, 5, 0, 0), child: const Text("Last sign in date",  style: TextStyle(color: Colors.white))),
        Container(margin: const EdgeInsets.fromLTRB(0, 5, 0, 0), child: Text(currentDate,  style: const TextStyle(color: Colors.white))),
      ],
    );
  }
}
