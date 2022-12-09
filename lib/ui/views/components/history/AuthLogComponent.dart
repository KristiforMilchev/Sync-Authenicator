import 'package:flutter/material.dart';
import 'package:synctest/ui/views/components/shared/CardComponent.dart';
import 'package:synctest/Assets/styles.dart';

class AuthLog extends StatelessWidget {
  final String SignedMessage =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";

  const AuthLog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardComponent(
        render: Column(
      children: [
        Container(
          child: Text("Message", style: TextStyle(color: ThemeColors.mainText)),
          margin: GeneralTheme.rowTopMargin,
        ),
        Container(
          child: Text("Peter did not enter the building",
              style: TextStyle(color: ThemeColors.innerText)),
          margin: GeneralTheme.rowInnerTopMargin,
        ),
        Container(
          child: Text("Generated Signature",
              style: TextStyle(color: ThemeColors.mainText)),
          margin: GeneralTheme.rowTopMargin,
        ),
        Container(
          child: Text(SignedMessage,
              style: TextStyle(color: ThemeColors.mainText)),
          margin: GeneralTheme.rowTopMargin,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              border: Border.all(
                  color: ThemeColors.innerText,
                  width: 1,
                  style: BorderStyle.solid),
              borderRadius: GeneralTheme.mainRounding,
              color: Color.fromRGBO(30, 30, 38, 1.0)),
        ),
        Container(
          margin: GeneralTheme.rowInnerTopMargin,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            verticalDirection: VerticalDirection.down,
            children: [
              Expanded(
                  child: Container(
                      margin: GeneralTheme.rowTopMargin,
                      child: Text("Last sign in date",
                          style: TextStyle(color: ThemeColors.innerText)))),
              Center(
                  child: Container(
                      margin: GeneralTheme.rowTopMargin,
                      child: Text("12/12/2021",
                          style: TextStyle(color: ThemeColors.innerText)))),
            ],
          ),
        )
      ],
    ));
  }
}
