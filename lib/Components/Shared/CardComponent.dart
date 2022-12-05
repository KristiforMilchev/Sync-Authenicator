import 'package:flutter/material.dart';


class CardComponent extends StatelessWidget {
  final Widget render;

  const CardComponent({Key? key, required this.render}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Expanded(child:
    Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children:  [
        Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Color.fromRGBO(40, 41, 49, 1)
          ),
          transformAlignment: Alignment.center,
          child: render
        )
      ],
    )
    );
  }
}
