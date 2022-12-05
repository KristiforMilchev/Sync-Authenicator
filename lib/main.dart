
import 'package:flutter/material.dart';
import 'Components/Shared/QrScannerComponent.dart';
import 'Components/Views/Home.dart';
import 'Components/Views/History.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  final screens = [HomePage(), HistoryPage(), HistoryPage()];

  Future<void> menuItemSelected(int currentIndex)
  async {
    print(index);
    if(currentIndex != 1)
    {
      print("Attempting to change state");
      setState(() {
        print(index);
        print("Changing State");
        this.index = currentIndex;
        print(index);
      });
    }
    else
    {
      //TODO implement barcode scanner.
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const QRViewExample(),
      ));
    }
  }
  

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        //rgba(,,,1)
        backgroundColor: const Color.fromRGBO(30,30,38, 1),
        title: Container(
          color: Colors.transparent,
          child: const Center(

            child:  Image(image: NetworkImage("https://linksync.tech/Logov2.png"), width: 150,height: 150,)
            ,
          ),
        ),
      ),
      body: Container(
        key: const Key("Test"),
        child: screens[index],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromRGBO(30,30,38, 1),
        fixedColor: Colors.redAccent,
        unselectedItemColor: Colors.white,
        currentIndex: index,
        items: const [
          BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home, color: Colors.white), activeIcon: Icon(Icons.home, color: Colors.redAccent)),
          BottomNavigationBarItem(label: "Scan", icon: Icon(Icons.camera_alt, color: Colors.white), activeIcon: Icon(Icons.camera_alt, color: Colors.redAccent)),
          BottomNavigationBarItem(label: "History", icon: Icon(Icons.history, color: Colors.white), activeIcon: Icon(Icons.history, color: Colors.redAccent)),
        ],
        onTap: (index) => menuItemSelected(index),
      ),

    );
  }
}
