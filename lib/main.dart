import 'package:flutter/material.dart';
import 'Components/Shared/QrScannerComponent.dart';
import 'Components/Views/home.dart';
import 'Components/Views/History.dart';
import 'package:synctest/Assets/styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;
  final screens = [ const HomePage(), null, const  HistoryPage()];

  Future<void> menuItemSelected(int currentIndex) async {
    print(index);
    if (currentIndex != 1) {
      print("Attempting to change state");
      setState(() {
        print(index);
        print("Changing State");
        this.index = currentIndex;
        print(index);
      });
    } else {
      //TODO implement barcode scanner.
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const QRViewExample(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        //rgba(,,,1)
        backgroundColor: ThemeColors.mainThemeBackground,
        title: Container(
          color: Colors.transparent,
          child: const Center(
            child: Image(
              image: NetworkImage("https://linksync.tech/Logov2.png"),
              width: 150,
              height: 150,
            ),
          ),
        ),
      ),
      body: Container(
        key: const Key("Test"),
        child: screens[index],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ThemeColors.mainThemeBackground,
        fixedColor: ThemeColors.activeMenu,
        unselectedItemColor: ThemeColors.mainText,
        currentIndex: index,
        items: [
          BottomNavigationBarItem(
              label: "Home",
              icon: Icon(Icons.home, color: ThemeColors.mainText),
              activeIcon: Icon(Icons.home, color: ThemeColors.activeMenu)),
          BottomNavigationBarItem(
              label: "Scan",
              icon: Icon(Icons.camera_alt, color: ThemeColors.mainText),
              activeIcon:
                  Icon(Icons.camera_alt, color: ThemeColors.activeMenu)),
          BottomNavigationBarItem(
              label: "History",
              icon: Icon(Icons.history, color: ThemeColors.mainText),
              activeIcon: Icon(Icons.history, color: ThemeColors.activeMenu)),
        ],
        onTap: (index) => menuItemSelected(index),
      ),
    );
  }
}
