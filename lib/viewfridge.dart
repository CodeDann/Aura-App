import 'package:flutter/material.dart';
import 'package:food_waste/main.dart';
import 'package:food_waste/shoppinglist.dart';

class viewfridge extends StatelessWidget {
  const viewfridge({Key? key}) : super(key: key);

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
        title: const Text('View Fridge'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'INSERT FRIDGE IMAGE HERE',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ),
    );
  }
}