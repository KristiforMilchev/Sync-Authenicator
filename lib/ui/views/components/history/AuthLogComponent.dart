import 'package:flutter/material.dart';
import 'package:synctest/ui/views/components/shared/CardComponent.dart';
import 'package:synctest/Assets/styles.dart';

class AuthLog extends StatelessWidget {
  final String? signedMessage;
  final String? signature;
  final String? signatureDate;

  const AuthLog(
      {Key? key,
      required this.signedMessage,
      required this.signature,
      required this.signatureDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardComponent(
        render: Column(
      children: [
        Container(
          margin: GeneralTheme.rowTopMargin,
          child: Text("Message", style: TextStyle(color: ThemeColors.mainText)),
        ),
        Container(
          margin: GeneralTheme.rowInnerTopMargin,
          child: Text(signedMessage!,
              style: TextStyle(color: ThemeColors.innerText)),
        ),
        Container(
          margin: GeneralTheme.rowTopMargin,
          child: Text("Generated Signature",
              style: TextStyle(color: ThemeColors.mainText)),
        ),
        Container(
          margin: GeneralTheme.rowTopMargin,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              border: Border.all(
                  color: ThemeColors.innerText,
                  width: 1,
                  style: BorderStyle.solid),
              borderRadius: GeneralTheme.mainRounding,
              color: const Color.fromRGBO(30, 30, 38, 1.0)),
          child:
              Text(signature!, style: TextStyle(color: ThemeColors.mainText)),
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
                      child: Text(signatureDate!,
                          style: TextStyle(color: ThemeColors.innerText)))),
            ],
          ),
        )
      ],
    ));
  }
}
