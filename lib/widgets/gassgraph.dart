import 'dart:ffi';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_titled_container/flutter_titled_container.dart';

// widget import
import 'package:food_waste/widgets/GraphAxisNames.dart';

// firestore installs
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';


class gassgraph extends StatefulWidget {
  const gassgraph({Key? key}) : super(key: key);

  @override
  State<gassgraph> createState() => _gassgraph();
}

class _gassgraph extends State<gassgraph> {

  List<dynamic> contents = [];
  FirebaseFirestore Database = FirebaseFirestore.instance;
  late DateTime Today = DateTime.now();
  //default date formatter for the page
  DateFormat formatter = DateFormat('yyyy-MM-dd');

  //graphing variables
  final List<Color> gradientColors1 = [
    const Color.fromRGBO(0, 0, 255, 0.8),
    const Color.fromRGBO(0, 100, 255, 0.8),
  ];
  final List<Color> gradientColors2 = [
    const Color.fromRGBO(250, 0, 0, 0.8),
    const Color.fromRGBO(250, 100, 0, 0.8),
  ];
  final List<Color> gradientColors3 = [
    const Color.fromRGBO(0, 255, 0, 0.8),
    const Color.fromRGBO(100, 255, 0, 0.8),
  ];

  // gets data on page load
  Future<void> _getData() async {
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
  }

  double doubleInRange( num start, num end) {
    var source = new Random();
    return source.nextDouble() * (end - start) + start;
  }

  List<FlSpot> _getSpots(String name){
    List<FlSpot> spots = [];
    print(contents.length);
    try{
      for( int i = 0; i < 7; i++ ){
        spots.add(FlSpot(i.toDouble(), double.parse('${contents[i][name]}')));
      }
      print("Loaded data from database");
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


  LineTitles oxidationxy = LineTitles(4);
  LineTitles reductionxy = LineTitles(5);
  LineTitles ammoniaxy = LineTitles(6);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 40, 20, 0),
      child: Column(
        children: [
          //oxidation graph
          TitledContainer(
            titleColor: Colors.black,
            title: 'Oxidation',
            fontSize: 15.0,
            textAlign: TextAlignTitledContainer.Center,
            backgroundColor: gradientColors1[1],
            child:Container(
              width: (MediaQuery.of(context).size.width),
              height: (MediaQuery.of(context).size.height)/4.5,
              padding: EdgeInsets.fromLTRB(10, 20, 40, 10),
              child: LineChart(
                LineChartData(
                  minX: 0,
                  maxX: 6,
                  minY: 0,
                  maxY: 50,
                  titlesData: oxidationxy.getTitleData(),
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
                      spots: _getSpots('Oxidation'),
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
                  ],
                ),
              ),
            ),
          ),
          //Reduction graph
          TitledContainer(
            titleColor: Colors.black,
            title: 'Reduction',
            fontSize: 15.0,
            textAlign: TextAlignTitledContainer.Center,
            backgroundColor: gradientColors2[0],
            child:Container(
              width: (MediaQuery.of(context).size.width),
              height: (MediaQuery.of(context).size.height)/4.5,
              padding: EdgeInsets.fromLTRB(10, 20, 40, 10),
              child: LineChart(
                LineChartData(
                  minX: 0,
                  maxX: 6,
                  minY: 0,
                  maxY: 500,
                  titlesData: reductionxy.getTitleData(),
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
                      spots: _getSpots('Reduction'),
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
                  ],
                ),
              ),
            ),
          ),
          //ammonia graph
          TitledContainer(
            titleColor: Colors.black,
            title: 'Ammonia',
            fontSize: 15.0,
            backgroundColor: gradientColors3[0],
            textAlign: TextAlignTitledContainer.Center,
            child:Container(
              width: (MediaQuery.of(context).size.width),
              height: (MediaQuery.of(context).size.height)/4.5,
              padding: EdgeInsets.fromLTRB(10, 20, 40, 10),
              child: LineChart(
                LineChartData(
                  minX: 0,
                  maxX: 6,
                  minY: 0,
                  maxY: 300,
                  titlesData: ammoniaxy.getTitleData(),
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
                      spots: _getSpots('Ammonia'),
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
          ),
        ]
      ),
    );
  }
}

