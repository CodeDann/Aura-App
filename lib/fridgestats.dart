import 'package:flutter/material.dart';
import 'package:food_waste/main.dart';
import 'package:food_waste/viewfridge.dart';
import 'package:food_waste/shoppinglist.dart';
import 'package:food_waste/wastedfood.dart';
import 'package:food_waste/myfood.dart';
import 'package:food_waste/recipiegenerator.dart';
import 'package:food_waste/wasteawareness.dart';
import 'package:food_waste/fridgestats.dart';

// firestore installs
import 'package:cloud_firestore/cloud_firestore.dart';

class fridgestats extends StatefulWidget {
  const fridgestats({Key? key}) : super(key: key);


  @override
  State<fridgestats> createState() => _fridgestats();
}

class _fridgestats extends State<fridgestats> {

  List<dynamic> contents = [];

  FirebaseFirestore Database = FirebaseFirestore.instance;

  int _selectedIndex = 0;


  // gets data on page load
  Future<void> _getData() async {
    // get document from database
    DocumentSnapshot snapshot = await Database.collection('FoodWasteData').doc('sensordata').get();
    // convert data to a map
    var data = snapshot.data() as Map;
    var dataArr = data['items'] as List;

    contents = dataArr;

    //build page with updated values
    setState(() {
      contents;
    });
  }

  @override
  void initState() {
    _getData().then((value){
      print('Async data load done');
    });
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _showgraph(index){
    switch( index ){
      case 0:
        return( Text('${contents[0]["Temperature"]}') );
        break;
      case 1:
        return( Text('${contents[0]["Humidity"]}') );
        break;
      case 2:
        return( Text('${contents[0]["Particle1"]}') );
        break;
      default:
        return( Text('DEFAULT VALUE') );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent,
              ),
              child: Text('Menu'),
            ),
            ListTile(
              title: const Text('Homepage'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Homepage')),
                );
              },
            ),
            ListTile(
              title: const Text('View Fridge'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const viewfridge()),
                );
              },
            ),
            ListTile(
              title: const Text('Shopping List'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const shoppinglist()),
                );
              },
            ),
            ListTile(
              title: const Text('Wasted Food'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const wastedfood()),
                );
              },
            ),
            ListTile(
              title: const Text('Fridge Contents'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const myfood()),
                );
              },
            ),
            ListTile(
              title: const Text('Recipie Generator'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const recipiegenerator()),
                );
              },
            ),
            ListTile(
              title: const Text('Food Waste Awareness'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const wasteawareness()),
                );
              },
            ),
            ListTile(
              title: const Text('Fridge Stats'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const fridgestats()),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Fridge Stats'),
      ),
      body: _showgraph(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.thermostat),
            label: 'Temp',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.water_outlined),
            label: 'Humidity',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.air),
            label: 'Particles',
          ),
        ],
      ),

    );
  }

}