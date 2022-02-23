import 'package:flutter/material.dart';

//widget imports
import 'package:food_waste/widgets/navdrawer.dart';
import 'package:food_waste/widgets/tempgraph.dart';
import 'package:food_waste/widgets/pressuregraph.dart';
import 'package:food_waste/widgets/particlegraph.dart';
import 'package:food_waste/widgets/gassgraph.dart';


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
        return(pressuregraph());
      case 2:
        return (particlegraph());
        break;
      case 3:
        return (gassgraph());
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
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.thermostat),
            label: 'Temp',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sensors_rounded),
            label: 'Humid & Press',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.blur_on_sharp),
            label: 'Particles',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.air),
            label: 'Gasses',
          ),
        ],
      ),

    );
  }

}