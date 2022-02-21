import 'package:flutter/material.dart';

// page installs
import 'package:food_waste/main.dart';
import 'package:food_waste/viewfridge.dart';
import 'package:food_waste/shoppinglist.dart';
import 'package:food_waste/wastedfood.dart';
import 'package:food_waste/myfood.dart';
import 'package:food_waste/recipiegenerator.dart';
import 'package:food_waste/wasteawareness.dart';
import 'package:food_waste/fridgestats.dart';

// firebase and firestore installs
// import 'package:firebase_core/firebase_core.dart/';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';


class myfood extends StatefulWidget {
  const myfood({Key? key}) : super(key: key);

  @override
  State<myfood> createState() => _myfood();
}

class _myfood extends State<myfood> {

  List<dynamic> contents = [];

  FirebaseFirestore Database = FirebaseFirestore.instance;

  late String codeDialog;
  late Map addedItem = {};
  late DateTime selectedDate = DateTime.now();

  //default date formatter for the page
  DateFormat formatter = DateFormat('yyyy-MM-dd');

  TextEditingController _textFieldController1 = TextEditingController();
  TextEditingController _textFieldController2 = TextEditingController();
  TextEditingController _textFieldController3 = TextEditingController();

  // gets data on page load
  Future<void> _getData() async {
    // get document from database
    DocumentSnapshot snapshot = await Database.collection('FoodWasteData').doc('wastedfood').get();
    // convert data to a map
    var data = snapshot.data() as Map;
    var dataArr = data['items'] as List;

    //convert the map from the db into a Array of Maps
    for( int i = 0; i < dataArr.length; i++){
      // handle the date and format nicely
      DateTime date = dataArr[i]['Date'].toDate();
      String formattedDate = formatter.format(date);
      dataArr[i]['Date'] = formattedDate;
    }
    contents = dataArr;

    //build page with updated values
    setState(() {
      contents;
    });
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        addedItem['Date'] = formatter.format(picked);
      });
    }
  }


  // handles the textpopup
  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
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
                    decoration: const InputDecoration(hintText: "Reason"),
                  ),
                  TextField(
                    controller: _textFieldController3,
                    decoration: const InputDecoration(hintText: "Quantity"),
                  ),
                  RaisedButton(
                    onPressed: () => _selectDate(context),
                    child: Text('Select Date'),
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
                      _textFieldController3.clear();
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
                    addedItem['Name'] = _textFieldController1.text;
                    addedItem['Reason'] = _textFieldController2.text;
                    addedItem['Quantity'] = _textFieldController3.text;
                    _additem(addedItem);
                    addedItem = {};
                    setState(() {
                      _textFieldController1.clear();
                      _textFieldController2.clear();
                      _textFieldController3.clear();
                      Navigator.pop(context);
                    });
                  },
                ),

              ],
            );
          });
        });
  }

  //adds item to contents and db then rebuilds page
  void _additem(Map item){

    //add to contents
    contents.add(item);

    //add item to database
    // create a map with the contents of contents
    Map<String, dynamic> map = new Map();
    List<Map> items = [];
    for( int i = 0; i < contents.length; i++){
      //asign the correct key value pairs
      map["Date"] = DateTime.parse(contents[i]['Date']);
      map["Name"] = contents[i]['Name'];
      map["Reason"] = contents[i]['Reason'];
      map["Quantity"] = contents[i]['Quantity'];
      items.add(map);
      map = {};
    }

    //sets the entire document contents to map
    Database.collection('FoodWasteData').doc('wastedfood').set({'items': items});

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
      map["Date"] = DateTime.parse(contents[i]['Date']);
      map["Name"] = contents[i]['Name'];
      map["Reason"] = contents[i]['Reason'];
      map["Quantity"] = contents[i]['Quantity'];
      items.add(map);
      map = {};
    }

    //sets the entire document contents to map
    Database.collection('FoodWasteData').doc('wastedfood').set({'items': items});

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
                  color: Colors.deepPurpleAccent,
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
              ListTile(
                title: const Text('Fridge Contents'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const myfood()),
                  );
                },
              ),
              ListTile(
                title: const Text('Recipie Generator'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const recipiegenerator()),
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
        ),
        appBar: AppBar(
          title: const Text('Wasted Food'),
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: contents.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              tileColor: Colors.greenAccent,
              leading: IconButton(
                onPressed: () => _removeItem(index),
                icon: const Icon(Icons.delete_forever),
              ),
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(child: Text(contents[index]['Name'],),),
                    Expanded(child: Text(contents[index]['Reason'],),),
                    Expanded(child: Text(contents[index]['Quantity'],),),
                    Expanded(child: Text(contents[index]['Date'],),),
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

