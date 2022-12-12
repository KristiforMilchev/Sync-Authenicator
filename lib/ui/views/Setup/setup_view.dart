import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

import 'package:stacked/stacked.dart';
import 'package:synctest/ui/views/Setup/setup_viewmodel.dart';

import '../../../Assets/styles.dart';

class SetupView extends StatelessWidget {
  const SetupView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SetupViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: PageView(
          onPageChanged: ((action) => model.pageChanged(action, context)),
          controller: PageController(initialPage: 1),
          children: [
            Container(
              color: ThemeColors.mainThemeBackground,
              child: const Center(child: Text("Ok")),
            ),
            Container(
              alignment: Alignment.center,
              color: ThemeColors.mainThemeBackground,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Image(
                    image: NetworkImage(
                        "https://escrow.linksync.tech/logomain.png"),
                    width: 200,
                    height: 100,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Sync Authenticator",
                    style: TextStyle(
                        color: ThemeColors.mainText,
                        decoration: TextDecoration.none,
                        fontStyle: FontStyle.italic,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    "The linksync authenicator is a web3 based 2 factor authenicator manager designed around the SYNC 2FA authorization protocol.",
                    textAlign: TextAlign.center,
                    softWrap: true,
                    textWidthBasis: TextWidthBasis.longestLine,
                    style: TextStyle(
                      color: ThemeColors.innerText,
                      decoration: TextDecoration.none,
                      fontStyle: FontStyle.italic,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Chip(
                    label: Text(
                      "Developer Documentation",
                      style: TextStyle(color: Colors.white),
                    ),
                    avatar:
                        Icon(Icons.wb_iridescent_rounded, color: Colors.white),
                    backgroundColor: Color.fromARGB(255, 170, 49, 77),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Scroll right to create new account",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: ThemeColors.innerText,
                            decoration: TextDecoration.none,
                            fontStyle: FontStyle.italic,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.arrow_circle_right,
                        color: ThemeColors.innerText,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_circle_left,
                        color: ThemeColors.innerText,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Scroll left to import existing account",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: ThemeColors.innerText,
                            decoration: TextDecoration.none,
                            fontStyle: FontStyle.italic,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              color: ThemeColors.mainThemeBackground,
              child: const Center(child: Text("Ok")),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => SetupViewModel(),
      onModelReady: (viewModel) => viewModel.initialise(),
    );
  }
}
