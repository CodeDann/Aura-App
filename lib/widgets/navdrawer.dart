import 'package:flutter/material.dart';
import 'package:food_waste/main.dart';
import 'package:food_waste/viewfridge.dart';
import 'package:food_waste/myfood.dart';
import 'package:food_waste/recipiegenerator.dart';
import 'package:food_waste/wasteawareness.dart';
import 'package:food_waste/fridgestats.dart';

class navdrawer extends StatefulWidget {
  const navdrawer({Key? key}) : super(key: key);

  @override
  State<navdrawer> createState() => _navdrawer();
}

class _navdrawer extends State<navdrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
            child: Text(''),
          ),
          ListTile(
            title: const Text('Dashboard'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MyHomePage(title: 'Dashboard')),
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
            title: const Text('My Food'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const myfood()),
              );
            },
          ),
          ListTile(
            title: const Text('Recipe Generator'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const recipiegenerator()),
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
    );
  }
}