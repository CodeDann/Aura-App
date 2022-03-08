import 'package:flutter/material.dart';


//widget imports
import 'package:food_waste/widgets/navdrawer.dart';
import 'package:food_waste/widgets/shoppinglist.dart';
import 'package:food_waste/widgets/wastedfood.dart';
import 'package:food_waste/widgets/fridgecontents.dart';


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
  //TODO Error when adding new item as if you lick add without filling out fields it correctly stops you from adding the item. However when you finally add it it adds how many times u clicked the icon
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
        drawer: navdrawer(),
        body: _showPage(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.data_saver_on_rounded),
            label: 'Fridge Contents',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart_outlined),
            label: 'Shoppping List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_delete_outlined),
            label: 'Wasted Food',
          ),
        ],
      ),
    );
  }
}

