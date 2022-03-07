import 'package:flutter/material.dart';

// firestore installs
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:openfoodfacts/openfoodfacts.dart';


class fridgecontents extends StatefulWidget {
  const fridgecontents({Key? key}) : super(key: key);

  @override
  State<fridgecontents> createState() => _fridgecontents();
}

class _fridgecontents extends State<fridgecontents> {

  List<dynamic> contents = [];

  FirebaseFirestore Database = FirebaseFirestore.instance;

  late String codeDialog;
  late Map addedItem = {};
  late DateTime Today = DateTime.now();
  late DateTime selectedDate = Today.add(Duration(days: 5));

  //default date formatter for the page
  DateFormat formatter = DateFormat('yyyy-MM-dd');

  TextEditingController _textFieldController1 = TextEditingController();
  TextEditingController _textFieldController2 = TextEditingController();

  // gets data on page load
  Future<void> _getData() async {
    // get document from database
    DocumentSnapshot snapshot = await Database.collection('FoodWasteData').doc('fridgecontents').get();
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
      firstDate: Today,
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
                    decoration: const InputDecoration(hintText: "Quantity"),
                  ),
                  RaisedButton(
                    onPressed: () => _selectDate(context),
                    child: Text('Select Expiry Date'),
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
                    addedItem['Name'] = _textFieldController1.text;
                    addedItem['Quantity'] = _textFieldController2.text;
                    _additem(addedItem);
                    addedItem = {};
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
        });
  }

  //opens camera and scans a barcode
  Future<void> _scanBarcode() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    //Need to make this a flash popup on the screen not a console print
    getProduct(barcodeScanRes).then((scannedProduct){
      if ( scannedProduct == null ){
        print("Error no data for this barcode in the database");
      }
      else{
        Map itemToAdd = {};
        itemToAdd['Date'] = formatter.format(selectedDate).toString();
        itemToAdd['Name'] = scannedProduct.productName.toString();
        if( scannedProduct.quantity.toString() == 'null' ){
          itemToAdd['Quantity'] = "1 Item";
        } else{
          itemToAdd['Quantity'] = scannedProduct.quantity.toString();
        }
        _additem(itemToAdd);
      }
    });

  }

  //returns product info about a barcode
  Future<Product?> getProduct(String scannedBarcode) async {
    var barcode = scannedBarcode;

    ProductQueryConfiguration configuration = ProductQueryConfiguration(barcode,
        language: OpenFoodFactsLanguage.ENGLISH, fields: [ProductField.ALL]);
    ProductResult result = await OpenFoodAPIClient.getProduct(configuration);

    if (result.status == 1) {
      return result.product;
    } else {
      return null;
    }
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
      map["Quantity"] = contents[i]['Quantity'];
      items.add(map);
      map = {};
    }

    //sets the entire document contents to map
    Database.collection('FoodWasteData').doc('fridgecontents').set({'items': items});

    //rebuild page with updated contents
    setState(() {
      contents;
    });
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
      map["Quantity"] = contents[i]['Quantity'];
      items.add(map);
      map = {};
    }

    //sets the entire document contents to map
    Database.collection('FoodWasteData').doc('fridgecontents').set({'items': items});

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
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: contents.length+1,
        itemBuilder: (BuildContext context, int index) {
          if ( index == 0){
            return ListTile(
              leading: Visibility(
                child: IconButton(
                  onPressed: null,
                  icon: const Icon(Icons.check_box_rounded),
                ),
                visible: false,
              ),
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(child: Text('Name'),),
                    Expanded(child: Text('Quantity'),),
                    Expanded(child: Text('Date'),),
                  ]
              ),
            );
          }// end if
          index -= 1;
          return ListTile(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            tileColor: Colors.indigoAccent,
            leading: IconButton(
              onPressed: () => _removeItem(index),
              icon: const Icon(Icons.delete_forever),
            ),
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: Text(contents[index]['Name'],),),
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
              onPressed: _scanBarcode,
              tooltip: 'Scan in a barcode',
              child: const Icon(Icons.camera_alt_outlined),
            ),
          ),
        ],
      ),
    );
  }
}

