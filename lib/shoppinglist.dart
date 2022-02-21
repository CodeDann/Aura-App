import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:food_waste/main.dart';
import 'package:food_waste/viewfridge.dart';
// firebase and firestore installs
// import 'package:firebase_core/firebase_core.dart/';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_waste/wastedfood.dart';


class shoppinglist extends StatefulWidget {
  const shoppinglist({Key? key}) : super(key: key);

  @override
  State<shoppinglist> createState() => _shoppinglist();
}

class _shoppinglist extends State<shoppinglist> {

  List<List<String>> contents = [];

  FirebaseFirestore Database = FirebaseFirestore.instance;

  late String codeDialog;
  late List<String> addedItem = [];

  TextEditingController _textFieldController1 = TextEditingController();
  TextEditingController _textFieldController2 = TextEditingController();

  // gets data on page load
  Future<void> _getData() async {
    // get document from database
    DocumentSnapshot snapshot = await Database.collection('FoodWasteData').doc('shoplist').get();
    // convert data to a map
    var data = snapshot.data() as Map;
    var dataArr = data['items'] as List;

    //convert the map from the db into a 2d list of strings
    List<List<String>> items = [];
    for( int i = 0; i < dataArr.length; i++){
      List<String> item = [];
      item.add(dataArr[i]['Name']);
      item.add(dataArr[i]['Quantity']);
      items.add(item);
    }
    print(items);
    contents = items;

    //build page with updated values
    setState(() {
      contents;
    });
  }

  // handles the textpopup
  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add item'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: _textFieldController1,
                  decoration: const InputDecoration(hintText: "Item Name"),
                ),
                TextField(
                  controller: _textFieldController2,
                  decoration: const InputDecoration(hintText: "Quantity"),
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text('Cancel'),
                onPressed: () {
                  setState(() {
                    _textFieldController1.clear();
                    _textFieldController2.clear();
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('Add'),
                onPressed: () {
                  //get the values from both text boxes and call _addItem
                  addedItem.add(_textFieldController1.text);
                  addedItem.add(_textFieldController2.text);
                  _additem(addedItem);
                  addedItem = [];
                  setState(() {
                    _textFieldController1.clear();
                    _textFieldController2.clear();
                    Navigator.pop(context);
                  });
                },
              ),

            ],
          );
        });
  }

  //adds item to contents and db then rebuilds page
  void _additem(List<String> item){
    //add to contents
    contents.add(item);

    //add item to database
    // create a map with the contents of contents
    Map<String, dynamic> map = new Map();
    List<Map> items = [];
    for( int i = 0; i < contents.length; i++){
      //asign the correct key value pairs
      map["Name"] = contents[i][0];
      map["Quantity"] = contents[i][1];
      items.add(map);
      map = {};
    }

    //sets the entire document contents to map
    Database.collection('FoodWasteData').doc('shoplist').set({'items': items});

    //rebuild page with updated contents
    setState(() {
      contents;
    });
  }

  void _scanitem(){
    //open camera and scan in barcode then _additem()
  }

  //removes item at context[index] from page and db
  void _removeItem(int index){
    // remove item from internal contents
    contents.removeAt(index);

    //remove item from database
    // create a map with the contents of contents
    Map<String, dynamic> map = new Map();
    List<Map> items = [];
    for( int i = 0; i < contents.length; i++){
      //asign the correct key value pairs
      map["Name"] = contents[i][0];
      map["Quantity"] = contents[i][1];
      items.add(map);
      map = {};
    }

    //sets the entire document contents to map
    Database.collection('FoodWasteData').doc('shoplist').set({'items': items});

    //rebuild page with updated contents
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
              ListTile(
                title: const Text('Wasted Food'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const wastedfood()),
                  );
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text('View Fridge'),
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: contents.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                tileColor: Colors.greenAccent,
                leading: IconButton(
                  onPressed: () => _removeItem(index),
                  icon: const Icon(Icons.check_box_rounded),
                ),
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(child: Text(contents[index][0],),),
                      Expanded(child: Text(contents[index][1],),),
                    ]
                ),
              );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              left: 30,
              bottom: 20,
              child: FloatingActionButton(
                heroTag: 'addBtn',
                onPressed: () {_displayTextInputDialog(context);},
                tooltip: 'Add an item',
                child: const Icon(Icons.add),
              ),
            ),
            Positioned(
              right: 30,
              bottom: 20,
              child: FloatingActionButton(
                heroTag: 'scanBtn',
                onPressed: _scanitem,
                tooltip: 'Scan in a barcode',
                child: const Icon(Icons.camera_alt_outlined),
              ),
            ),
          ],
        )
    );
  }
}

