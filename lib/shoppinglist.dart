import 'package:flutter/material.dart';
import 'package:food_waste/main.dart';
import 'package:food_waste/viewfridge.dart';
// firebase and firestore installs
// import 'package:firebase_core/firebase_core.dart/';
import 'package:cloud_firestore/cloud_firestore.dart';


class shoppinglist extends StatefulWidget {
  const shoppinglist({Key? key}) : super(key: key);

  @override
  State<shoppinglist> createState() => _shoppinglist();
}

class _shoppinglist extends State<shoppinglist> {


  // List<String> row = [];
  List<String> contents = [];
  List<int> colorCodes = [];

  FirebaseFirestore Database = FirebaseFirestore.instance;

  Future<void> _getData() async {
    // get document from database
    DocumentSnapshot snapshot = await Database.collection('FoodWasteData').doc('shoppinglist').get();
    var data = snapshot.data() as Map;
    var shoppingData = data['items'] as List<dynamic>;

    List<String> shopping = [];
    for( int i = 0; i < shoppingData.length; i++){
      print(shoppingData[i]);
      shopping.add(shoppingData[i]);
      colorCodes.add(100);
    }
    contents = shopping;
    for( int i = 0; i < contents.length; i++){
      print(contents[i]);
    }
    // shoppingData.forEach((item) {
    //   // each item is a row of the db
    //   var itemContents = item as Map;
    //   for( int i = 0; i < itemContents.length; i++ ){
    //     contents.add(itemContents[i].toString());
    //     colorCodes.add(100);
    //     print(contents[i]);
    //   }
    // });
    setState(() {
      contents;
      colorCodes;
    });
  }

  void _removeItem(int index){
    print('before removing: ' + contents.toString());
    contents.removeAt(index);
    colorCodes.removeAt(index);
    print('after removing: ' + contents.toString());
    setState(() {
      contents;
      colorCodes;
    });

  }
  @override
  void initState() {
    _getData().then((value){
      print('Async data load done');
    });
    super.initState();
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
                color: Colors.red,
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
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Shopping List'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: contents.length,
        itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 50,
          color: Colors.redAccent[colorCodes[index]],
          child: Row(
              children: [
                IconButton(
                  onPressed: () => _removeItem(index),
                  icon: const Icon(Icons.delete_forever),
                ),
                Text(contents[index]),
              ]
          ),
        );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getData,
        tooltip: 'CLick to get data from database',
        child: const Icon(Icons.add),
      ),
    );
  }
}

