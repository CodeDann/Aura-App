import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// widget import
import 'package:food_waste/widgets/tempGraphAxisNames.dart';

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
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  // gets data on page load
  Future<void> _getData() async {
    // get document from database
    DocumentSnapshot snapshot = await Database.collection('FoodWasteData').doc('sensordata').get();
    // convert data to a map
    var data = snapshot.data() as Map;
    var dataArr = data['items'] as List;

    // //convert the map from the db into a Array of Maps
    // for( int i = 0; i < dataArr.length; i++){
    //   print(dataArr[i]);
    // }
    // print(contents);
    contents = dataArr;
    print(contents);

    //build page with updated values
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
    return Center(
      child: Container(
        width: (MediaQuery.of(context).size.width),
        height: (MediaQuery.of(context).size.height),
        padding: EdgeInsets.fromLTRB(0, 20, 20, 0),
        child: LineChart(
          LineChartData(
            minX: 0,
            maxX: 11,
            minY: 0,
            maxY: 6,
            titlesData: LineTitles.getTitleData(),
            gridData: FlGridData(
              show: true,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: const Color(0xff37434d),
                  strokeWidth: 1,
                );
              },
              drawVerticalLine: true,
              getDrawingVerticalLine: (value) {
                return FlLine(
                  color: const Color(0xff37434d),
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
                spots: [
                  FlSpot(0, 3),
                  FlSpot(2.6, 2),
                  FlSpot(4.9, 5),
                  FlSpot(6.8, 2.5),
                  FlSpot(8, 4),
                  FlSpot(9.5, 3),
                  FlSpot(11, 4),
                ],
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
    );
  }
}

