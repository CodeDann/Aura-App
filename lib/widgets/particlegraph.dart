import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_titled_container/flutter_titled_container.dart';

// widget import
import 'package:food_waste/widgets/GraphAxisNames.dart';

// firestore installs
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class particlegraph extends StatefulWidget {
  const particlegraph({Key? key}) : super(key: key);

  @override
  State<particlegraph> createState() => _particlegraph();
}

class _particlegraph extends State<particlegraph> {
  List<dynamic> contents = [];
  FirebaseFirestore Database = FirebaseFirestore.instance;
  late DateTime Today = DateTime.now();
  //default date formatter for the page
  DateFormat formatter = DateFormat('yyyy-MM-dd');

  LineTitles particlexy = LineTitles(3);

  //graphing variables
  final List<Color> gradientColors1 = [
    const Color.fromRGBO(134, 99, 186, 0.8),
    const Color.fromRGBO(98, 50, 168, 0.8),
  ];
  //graphing variables
  final List<Color> gradientColors2 = [
    const Color.fromRGBO(255, 54, 248, 0.8),
    const Color.fromRGBO(138, 26, 134, 0.8),
  ];
  //graphing variables
  final List<Color> gradientColors3 = [
    const Color.fromRGBO(240, 240, 240, 0.8),
    const Color.fromRGBO(173, 173, 173, 0.8),
  ];

  // gets data on page load
  Future<int> _getData() async {
    // get document from database
    DocumentSnapshot snapshot =
        await Database.collection('FoodWasteData').doc('sensordata').get();
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



  double doubleInRange(num start, num end) {
    var source = new Random();
    return source.nextDouble() * (end - start) + start;
  }

  List<FlSpot> _getSpots(String Name) {
    List<FlSpot> spots = [];
    try {
      for (int i = 0; i < 7; i++) {
        spots.add(FlSpot(i.toDouble(), double.parse('${contents[i][Name]}')));
      }
    } catch (ArrayIndexOutOfBoundsException) {
      print("Error not enough data to display graph");
      spots.clear();
      for (int i = 0; i < 7; i++) {
        spots.add(FlSpot(i.toDouble(), doubleInRange(2, 6)));
      }
    }
    return spots;
  }

  double _getMaxData(){
    double maxVal = 0;
    if( contents.isEmpty){ return maxVal; }
    for( int i = 0; i < contents.length; i++){
      if(contents[i]['Particle1'] > maxVal){
        maxVal = contents[i]['Particle1'];
      }
      else if(contents[i]['Particle10'] > maxVal){
        maxVal = contents[i]['Particle10'];
      }
      else if(contents[i]['Particle25'] > maxVal){
        maxVal = contents[i]['Particle25'];
      }
    }
    return maxVal*1.2;
  }

  @override
  void initState() {
    _getData().then((value) {
      print('Async data load done');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // waits to get data from db before building the graph
    // while waiting it shows a circular progress wheel
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
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 20, 40, 0),
                    child: RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Particle1   ',
                              style: TextStyle(color: gradientColors1[0])),
                          TextSpan(
                              text: 'Particle10   ',
                              style: TextStyle(color: gradientColors2[0])),
                          TextSpan(
                              text: 'Particle25',
                              style: TextStyle(color: gradientColors3[1])),
                        ],
                      ),
                    ),
                  ),
                  //particle graph container
                  Container(
                    width: (MediaQuery.of(context).size.width),
                    height: (MediaQuery.of(context).size.height)/1.5,
                    padding: EdgeInsets.fromLTRB(0, 20, 40, 0),
                    child: LineChart(
                      LineChartData(
                        minX: 0,
                        maxX: 6,
                        minY: 0,
                        maxY: _getMaxData(),
                        titlesData: particlexy.getTitleData(),
                        clipData: FlClipData.all(),
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
                            spots: _getSpots("Particle1"),
                            isCurved: true,
                            colors: gradientColors1,
                            barWidth: 5,
                            // dotData: FlDotData(show: false),
                            belowBarData: BarAreaData(
                              show: true,
                              colors: gradientColors1
                                  .map((color) => color.withOpacity(0.3))
                                  .toList(),
                            ),
                          ),
                          LineChartBarData(
                            spots: _getSpots("Particle10"),
                            isCurved: true,
                            colors: gradientColors2,
                            barWidth: 5,
                            // dotData: FlDotData(show: false),
                            belowBarData: BarAreaData(
                              show: true,
                              colors: gradientColors2
                                  .map((color) => color.withOpacity(0.3))
                                  .toList(),
                            ),
                          ),
                          LineChartBarData(
                            spots: _getSpots("Particle25"),
                            isCurved: true,
                            colors: gradientColors3,
                            barWidth: 5,
                            // dotData: FlDotData(show: false),
                            belowBarData: BarAreaData(
                              show: true,
                              colors: gradientColors3
                                  .map((color) => color.withOpacity(0.3))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        }
    );
  }
}
