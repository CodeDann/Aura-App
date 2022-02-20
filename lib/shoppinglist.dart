import 'dart:collection';

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

  List<String> contents = [];

  FirebaseFirestore Database = FirebaseFirestore.instance;

  Future<void> _getData() async {
    // get document from database
    DocumentSnapshot snapshot = await Database.collection('FoodWasteData').doc('shoppinglist').get();
    // convert data to a map
    var data = snapshot.data() as Map;

    //iterate over map and add each value to contents
    List<String> shoppingdata = [];
    data.forEach((key, value) {
      shoppingdata.add(value);
    });
    contents = shoppingdata;

    //build page with updated values
    setState(() {
      contents;
    });
  }

  void _additem(){
    // add item to db and contents then rebuild
    String itemToAdd = 'Milk, 1L';

    //add to contents
    contents.add(itemToAdd);

    //add item to database
    // create a map with the contents of contents
    Map<String, dynamic> map = new Map();
    for( int i = 0; i < contents.length; i++){
      map["$i"] = contents[i];
    }
    //sets the entire document contents to map
    Database.collection('FoodWasteData').doc('shoppinglist').set(map);

    //rebuild page with updated contents
    setState(() {
      contents;
    });
  }

  void _scanitem(){
    //open camera and scan in barcode then _additem()
  }

  void _removeItem(int index){
    // remove item from internal contents
    contents.removeAt(index);

    //remove item from database

    // create a map with the contents of contents
    Map<String, dynamic> map = new Map();
    for( int i = 0; i < contents.length; i++){
      map["$i"] = contents[i];
    }
    //sets the entire document contents to map
    Database.collection('FoodWasteData').doc('shoppinglist').set(map);

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
          color: Colors.redAccent[100],
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: 30,
            bottom: 20,
            child: FloatingActionButton(
              heroTag: 'addBtn',
              onPressed: _additem,
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

