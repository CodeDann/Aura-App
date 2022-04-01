import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_titled_container/flutter_titled_container.dart';

// widget import
import 'package:food_waste/widgets/GraphAxisNames.dart';

// firestore installs
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';


class tempgraph extends StatefulWidget {
  const tempgraph({Key? key}) : super(key: key);

  @override
  State<tempgraph> createState() => _tempgraph();
}

class _tempgraph extends State<tempgraph> {

  List<dynamic> contents = [];
  FirebaseFirestore Database = FirebaseFirestore.instance;
  late DateTime Today = DateTime.now();
  //default date formatter for the page
  DateFormat formatter = DateFormat('yyyy-MM-dd');

  //graphing variables
  final List<Color> gradientColors = [
    const Color.fromRGBO(200, 0, 0, 0.8),
    const Color.fromRGBO(200, 100, 50, 0.8),
  ];

  LineTitles tempTitles = LineTitles(0);


  // gets data on page load
  Future<int> _getData() async {
    // get document from database
    DocumentSnapshot snapshot = await Database.collection('FoodWasteData').doc('sensordata').get();
    // convert data to a map
    var data = snapshot.data() as Map;
    var dataArr = data['items'] as List;

    contents = dataArr;

    //build page with updated values
    setState(() {
      contents;
    });

    return 1;
  }

  double doubleInRange( num start, num end) {
    var source = new Random();
    return source.nextDouble() * (end - start) + start;
  }

  List<FlSpot> _getSpots(){
    List<FlSpot> spots = [];
    try{
      for( int i = 0; i < 7; i++ ){
        spots.add(FlSpot(i.toDouble(), double.parse('${contents[i]["Temperature"]}')));
      }
    }catch(ArrayIndexOutOfBoundsException) {
      print("Error not enough data to display graph");
      spots.clear();
      for( int i = 0; i < 7; i++ ){
        spots.add(FlSpot(i.toDouble(), doubleInRange(2, 22)));
      }
    }
    return spots;
  }

  @override
  void initState() {
    _getData().then((value){
      print('Async data load done');
    });
    super.initState();
  }
  double _getMaxData(String name){
    double maxVal = 0;
    if( contents.isEmpty){ return maxVal; }
    for( int i = 0; i < contents.length; i++){
      if(contents[i][name] > maxVal){
        maxVal = contents[i][name];
      }
    }
    return maxVal*1.2;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getData(), // gets data from firestore
        builder : (BuildContext context, AsyncSnapshot snap){
          if(snap.data == null){
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(strokeWidth: 6),
                  )
                ],
              ),
            );
          }
          else{
            //return the widget that you want to display after loading
            return Container(
                padding: EdgeInsets.fromLTRB(0, 40, 20, 0),
                child: TitledContainer(
                  titleColor: Colors.black,
                  title: 'Temperature',
                  fontSize: 15.0,
                  textAlign: TextAlignTitledContainer.Center,
                  backgroundColor: gradientColors[0],
                  child: Container(
                    width: (MediaQuery.of(context).size.width),
                    height: (MediaQuery.of(context).size.height),
                    padding: EdgeInsets.fromLTRB(0, 20, 20, 0),
                    child: LineChart(
                      LineChartData(
                        minX: 0,
                        maxX: 6,
                        minY: 0,
                        maxY: _getMaxData('Temperature'),
                        titlesData: tempTitles.getTitleData(),
                        gridData: FlGridData(
                          show: true,
                          getDrawingHorizontalLine: (value) {
                            return FlLine(
                              color: const Color(0xc1c1c1FF),
                              strokeWidth: 1,
                            );
                          },
                          drawVerticalLine: true,
                          getDrawingVerticalLine: (value) {
                            return FlLine(
                              color: const Color(0xc1c1c1FF),
                              strokeWidth: 1,
                            );
                          },
                        ),
                        borderData: FlBorderData(
                          show: true,
                          border: Border.all(color: const Color(0xff37434d), width: 1),
                        ),
                        lineBarsData: [
                          LineChartBarData(
                            spots: _getSpots(),
                            isCurved: true,
                            colors: gradientColors,
                            barWidth: 5,
                            // dotData: FlDotData(show: false),
                            belowBarData: BarAreaData(
                              show: true,
                              colors: gradientColors
                                  .map((color) => color.withOpacity(0.3))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
            );
          }
        }
    );

  }
}

