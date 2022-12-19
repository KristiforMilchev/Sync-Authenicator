import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../../Assets/styles.dart';
import 'remove_connection_modal_viewmodal.dart';

class RemoveConnectionModal extends StatelessWidget {
  final String url;
  final String email;

  const RemoveConnectionModal(
      {super.key, required this.url, required this.email});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RemoveConnectionModalViewModel>.reactive(
        builder: (context, model, child) => Column(
              children: [
                Text(
                  "Do you really want to remove the connection?",
                  style: TextStyle(color: ThemeColors.mainText),
                ),
                Text(url),
                Text(
                  "For account: $email",
                  style: TextStyle(color: ThemeColors.mainText),
                ),
                ElevatedButton.icon(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => ThemeColors.mainThemeBackground),
                  ),
                  onPressed: (() => {}),
                  icon: Icon(
                    // <-- Icon
                    Icons.delete_forever,
                    color: ThemeColors.mainText,
                    size: 24.0,
                  ),
                  label: Text(
                    "Approve",
                    style: TextStyle(color: ThemeColors.mainText),
                  ), // <-- Text
                )
              ],
            ),
        viewModelBuilder: () => RemoveConnectionModalViewModel(),
        onModelReady: (model) => model.initialized());
  }
}
