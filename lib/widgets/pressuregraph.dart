import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_titled_container/flutter_titled_container.dart';

// widget import
import 'package:food_waste/widgets/GraphAxisNames.dart';

// firestore installs
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';


class pressuregraph extends StatefulWidget {
  const pressuregraph({Key? key}) : super(key: key);

  @override
  State<pressuregraph> createState() => _pressuregraph();
}

class _pressuregraph extends State<pressuregraph> {

  List<dynamic> contents = [];
  FirebaseFirestore Database = FirebaseFirestore.instance;
  late DateTime Today = DateTime.now();
  //default date formatter for the page
  DateFormat formatter = DateFormat('yyyy-MM-dd');

  LineTitles humidityxy = LineTitles(1);
  LineTitles pressurexy = LineTitles(2);

  //graphing variables
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  //graphing variables
  final List<Color> gradientColors2 = [
    const Color.fromRGBO(200, 120, 0, 0.8),
    const Color.fromRGBO(252, 206, 3, 0.8),
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

  List<FlSpot> _getSpots(String Name){
    List<FlSpot> spots = [];
    print(contents.length);
    try{
      for( int i = 0; i < 7; i++ ){
        spots.add(FlSpot(i.toDouble(), double.parse('${contents[i][Name]}')));
      }
      print("Loaded data from database");
    }catch(ArrayIndexOutOfBoundsException) {
      print("Error not enough data to display graph");
      spots.clear();
      for( int i = 0; i < 7; i++ ){
        spots.add(FlSpot(i.toDouble(), doubleInRange(2, 8)));
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

  LineTitles tempTitles = LineTitles(0);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 40, 20, 0),
      child: Column(
        children: [
          //Humidity graph
          TitledContainer(
            titleColor: Colors.black,
            title: 'Humidity',
            fontSize: 15.0,
            textAlign: TextAlignTitledContainer.Center,
            backgroundColor: gradientColors[1],
            child:Container(
              width: (MediaQuery.of(context).size.width),
              height: ((MediaQuery.of(context).size.height)/3),
              padding: EdgeInsets.fromLTRB(10, 20, 40, 10),
              child: LineChart(
                LineChartData(
                  minX: 0,
                  maxX: 6,
                  minY: 0,
                  maxY: 50,
                  titlesData: humidityxy.getTitleData(),
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
          ),
          //Pressure graph
          TitledContainer(
            titleColor: Colors.black,
            title: 'Pressure',
            fontSize: 15.0,
            textAlign: TextAlignTitledContainer.Center,
            backgroundColor: gradientColors2[1],
            child:Container(
              width: (MediaQuery.of(context).size.width),
              height: ((MediaQuery.of(context).size.height)/3),
              padding: EdgeInsets.fromLTRB(10, 20, 40, 10),
              child: LineChart(
                LineChartData(
                  minX: 0,
                  maxX: 6,
                  minY: 0,
                  maxY: 1500,
                  titlesData: pressurexy.getTitleData(),
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
                      spots: _getSpots("Pressure"),
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
        ],
      ),
    );
  }
}

