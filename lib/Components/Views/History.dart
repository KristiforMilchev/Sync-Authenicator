import 'package:flutter/material.dart';
import 'package:synctest/Components/History/AuthLogComponent.dart';
import '/Components/Shared/CardComponent.dart';
import '/Components/ConnectionComponent.dart';
import 'package:synctest/Assets/styles.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];


class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _State();
}

class _State extends State<HistoryPage> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeColors.mainThemeBackground,
      child: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Container(
                width: 300,
                transformAlignment: AlignmentDirectional.centerStart,
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: dropdownValue,
                  alignment: AlignmentDirectional.centerStart,
                  icon:  Icon(Icons.arrow_downward, color: ThemeColors.activeMenu),
                  elevation: 16,
                  focusColor: ThemeColors.activeMenu,
                  dropdownColor:  ThemeColors.mainThemeBackground,
                  style: TextStyle(color: ThemeColors.mainText),
                  underline: Container(
                    height: 2,
                    color: ThemeColors.activeMenu,
                    transformAlignment: AlignmentDirectional.centerStart,
                  ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Center(

                         child: Text(
                           value,
                           textAlign: TextAlign.center,
                          ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          const CardComponent(render: ConnectionComponent(url: "portal.azure.com", email: "kristifor@collaborativesoft.com", currentDate: "02/12/2022",IsMain: false)),
          const AuthLog()
        ],
      ),
    );
  }
}
