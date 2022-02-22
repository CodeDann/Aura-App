import 'package:flutter/material.dart';

//widget imports
import 'package:food_waste/widgets/navdrawer.dart';
import 'package:food_waste/widgets/tempgraph.dart';
import 'package:food_waste/widgets/pressuregraph.dart';
import 'package:food_waste/widgets/particlegraph.dart';


class fridgestats extends StatefulWidget {
  const fridgestats({Key? key}) : super(key: key);


  @override
  State<fridgestats> createState() => _fridgestats();
}

class _fridgestats extends State<fridgestats> {

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _showGraph(index){
    switch( index ){
      case 0:
        return(tempgraph());
        break;
      case 1:
        // return pressuregraph();
        return Text('text');
      case 2:
        // return particlegraph();
        return Text('text');
        break;
      default:
        // return tempgraph();
        return Text('text');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: navdrawer(),
      appBar: AppBar(
        title: const Text('Fridge Stats'),
      ),
      body: _showGraph(_selectedIndex),
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