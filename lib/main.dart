import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//page imports
import 'package:food_waste/myfood.dart';

//widget imports
import 'package:food_waste/widgets/navdrawer.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  // setup firebase db upon initilisation
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Waste App',
      theme: ThemeData(
          colorScheme: const ColorScheme(
            brightness: Brightness.dark,

            background: Colors.black38,
            primary: Colors.deepPurple,

            onPrimary: Colors.black,
            onBackground: Colors.black,

            secondary: Colors.deepPurple, //float action button
            onSecondary: Colors.white,

            error: Colors.black,
            onError: Colors.white,

            surface: Colors.deepPurple, // AppBar
            onSurface: Colors.white, //icons, inputs
          ),
      ),
      home: const MyHomePage(title: 'Dashboard'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    _getData().then((value) {
      print('Async data load done');
    });
    super.initState();
  }

  List<dynamic> contents = [{"Ammonia": 165.4831460674158, "Temperature": 16.349870572564523, "Reduction": 302.2697201017812, "Particle25": 5.0, "Humidity": 34.98262998530308, "Particle1": 1.0, "Particle10": 7.0, "Oxidation": 19.29987011994805, "Time": DateTime.now(), "Pressure": 1008.6456240224635}];
  FirebaseFirestore Database = FirebaseFirestore.instance;


  // gets data on page load
  Future<int> _getData() async {
    // get document from database
    DocumentSnapshot snapshot = await Database.collection('FoodWasteData').doc(
        'sensordata').get();
    // convert data to a map
    var data = snapshot.data() as Map;
    var dataArr = data['items'] as List;


    contents = dataArr;

    print(contents.last);

    //build page with updated values
    setState(() {
      contents;
    });

    return 1;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
              // nav drawer
              drawer: navdrawer(),
              appBar: AppBar(
                title: Text(widget.title),
              ),
              body: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Align(
                      alignment: Alignment.center,
                      child: AutoSizeText(
                        "${contents.last["Temperature"].toStringAsFixed(2)}°C",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                        ),
                        maxLines: 1,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(200, 0, 0, 0.6),
                      border: Border.all(
                        width: 3,
                        color: Colors.deepPurpleAccent,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Align(
                      alignment: Alignment.center,
                      child: AutoSizeText(
                        "P1: ${contents.last["Particle1"].toStringAsFixed(
                            2)}\nP10: ${contents.last["Particle10"]
                            .toStringAsFixed(2)}\nP25: ${contents
                            .last["Particle25"].toStringAsFixed(2)}",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                        ),
                        maxLines: 3,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(151, 5, 255, 0.6),
                      border: Border.all(
                        width: 3,
                        color: Colors.deepPurpleAccent,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Align(
                      alignment: Alignment.center,
                      child: AutoSizeText(
                        "${contents.last["Humidity"].toStringAsFixed(2)}%",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                        ),
                        maxLines: 1,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(43, 209, 255, 0.6),
                      border: Border.all(
                        width: 3,
                        color: Colors.deepPurpleAccent,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Align(
                      alignment: Alignment.center,
                      child: AutoSizeText(
                        "${contents.last["Pressure"].toStringAsFixed(2)}",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                        ),
                        maxLines: 1,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 242, 64, 0.6),
                      border: Border.all(
                        width: 3,
                        color: Colors.deepPurpleAccent,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Align(
                      alignment: Alignment.center,
                      child: AutoSizeText(
                        "O: ${contents.last["Oxidation"].toStringAsFixed(
                            2)}\nR: ${contents.last["Reduction"]
                            .toStringAsFixed(2)}\nNH4: ${contents
                            .last["Ammonia"].toStringAsFixed(2)}",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                        ),
                        maxLines: 3,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(100, 255, 0, 0.6),
                      border: Border.all(
                        width: 3,
                        color: Colors.deepPurpleAccent,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const myfood()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Align(
                        alignment: Alignment.center,
                        child: const Icon(Icons.playlist_add),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 3,
                          color: Colors.deepPurpleAccent,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ],
              ),
            );
  }
}
