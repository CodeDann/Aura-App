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

  final List<String> entries = <String>['1', '2', '3'];
  final List<int> colorCodes = <int>[100, 100, 100];

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
      body: Center(
        child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 50,
              color: Colors.amber[colorCodes[index]],
              child: Center(child: Text('Entry ${entries[index]}')),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
        ),
      ),
    );
  }
}