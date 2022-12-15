import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:synctest/ui/views/components/shared/signature_actions/signature_actions_viewmodel.dart';
import '../../../../../Assets/styles.dart';

class SignatureActionsView extends StatelessWidget {
  final String signedMessage;
  final String plainMessage;
  final String url;

  const SignatureActionsView(
      {super.key,
      required this.plainMessage,
      required this.signedMessage,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignatureActionsViewModel>.reactive(
      builder: (context, model, child) => Column(children: [
        Text("Request", style: TextStyle(color: ThemeColors.mainText)),
        const SizedBox(
          height: 10,
        ),
        Text(
          url,
          style: TextStyle(color: ThemeColors.innerText),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20,
        ),
        Text("Message", style: TextStyle(color: ThemeColors.mainText)),
        const SizedBox(
          height: 10,
        ),
        Text(plainMessage, style: TextStyle(color: ThemeColors.innerText)),
        const SizedBox(
          height: 20,
        ),
        Text("Generated Signature",
            style: TextStyle(color: ThemeColors.mainText)),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              border: Border.all(
                  color: ThemeColors.innerText,
                  width: 1,
                  style: BorderStyle.solid),
              borderRadius: GeneralTheme.mainRounding,
              color: const Color.fromRGBO(30, 30, 38, 1.0)),
          child: Text(
            signedMessage,
            style: TextStyle(color: ThemeColors.mainText),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton.icon(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith(
                (states) => ThemeColors.mainThemeBackground),
          ),
          onPressed: (() => model.savePressed()),
          icon: Icon(
            // <-- Icon
            model.btnIcon,
            color: ThemeColors.mainText,
            size: 24.0,
          ),
          label: Text(
            "Approve",
            style: TextStyle(color: ThemeColors.mainText),
          ), // <-- Text
        )
      ]),
      viewModelBuilder: () => SignatureActionsViewModel(),
      onModelReady: (viewModel) => viewModel.initialise(),
    );
  }
}
