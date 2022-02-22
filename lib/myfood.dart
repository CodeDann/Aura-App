import 'package:flutter/material.dart';
import 'package:food_waste/fridgecontents.dart';

//page imports
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
import 'package:intl/intl.dart';


class myfood extends StatefulWidget {
  const myfood({Key? key}) : super(key: key);

  @override
  State<myfood> createState() => _myfood();
}

class _myfood extends State<myfood> {

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _showPage(index){
    switch( index ){
      case 0:
        return fridgecontents();
        break;
      case 1:
        return shoppinglist();
      case 2:
        return wastedfood();
        break;
      default:
        return fridgecontents();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Food'),
        ),
        body: _showPage(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.thermostat),
            label: 'Fridge Contents',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.water_outlined),
            label: 'Shoppping List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.air),
            label: 'Wasted Food',
          ),
        ],
      ),
    );
  }
}

