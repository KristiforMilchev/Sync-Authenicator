import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:synctest/ui/views/components/home/signature_request_loader/signature_request_loader_viewmodel.dart';

import '../../../../../Assets/styles.dart';

class SignatureRequestLoader extends StatelessWidget {
  final String url;
  final String accountName;

  const SignatureRequestLoader(
      {super.key, required this.url, required this.accountName});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignatureRequestLoaderViewModel>.reactive(
      builder: (context, model, child) {
        if (model.requestState) {
          return SizedBox(
            height: 300,
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: ThemeColors.mainText,
                      semanticsValue: "Requesting message",
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text("Requesting message",
                    style: TextStyle(color: ThemeColors.innerText)),
              ],
            ),
          );
        } else {
          return model.render;
        }
      },
      viewModelBuilder: () => SignatureRequestLoaderViewModel(),
      onModelReady: (viewModel) =>
          viewModel.initialise(url, accountName, context),
    );
  }
}
