import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LineTitles {

  List<dynamic> contents = [];
  FirebaseFirestore Database = FirebaseFirestore.instance;

  // gets data on page load
  Future<void> _getData() async {
    // get document from database
    DocumentSnapshot snapshot = await Database.collection('FoodWasteData').doc('sensordata').get();
    // convert data to a map
    var data = snapshot.data() as Map;
    var dataArr = data['items'] as List;

    contents = dataArr;
  }

  LineTitles( this.type );

  int type;
  //set today
  late DateTime Today = DateTime.now();
  //default date formatter for the page
  DateFormat formatter = DateFormat('E');

  double _getMaxData(String name){
    _getData();
    double maxVal = 0;
    if( contents.isEmpty ){ return 1; }
    for( int i = 0; i < contents.length; i++){
      if(contents[i][name] > maxVal){
        maxVal = contents[i][name];
      }
    }
    return maxVal;
  }

  String _getDayTitles(index) {
    switch (index.toInt()) {
      case 0:
        return formatter.format(Today.add(Duration(days: -6)));
      case 1:
        return formatter.format(Today.add(Duration(days: -5)));
      case 2:
        return formatter.format(Today.add(Duration(days: -4)));
      case 3:
        return formatter.format(Today.add(Duration(days: -3)));
      case 4:
        return formatter.format(Today.add(Duration(days: -2)));
      case 5:
        return formatter.format(Today.add(Duration(days: -1)));
      case 6:
        return formatter.format(Today);
    }
    return '';
  }

  getTitleData(){
    //temp
    if( this.type == 0){
      String name = 'Temperature';
      return FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 35,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff68737d),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return formatter.format(Today.add(Duration(days: -6)));
              case 1:
                return formatter.format(Today.add(Duration(days: -5)));
              case 2:
                return formatter.format(Today.add(Duration(days: -4)));
              case 3:
                return formatter.format(Today.add(Duration(days: -3)));
              case 4:
                return formatter.format(Today.add(Duration(days: -2)));
              case 5:
                return formatter.format(Today.add(Duration(days: -1)));
              case 6:
                return formatter.format(Today);
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            return value.toInt().toString() + '°C';
          },
          interval: 5,
          reservedSize: 50,
          margin: 10,
        ),
      );
    }
    //humidity
    else if( this.type == 1){
      String name = 'Humidity';
      return FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 35,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff68737d),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return formatter.format(Today.add(Duration(days: -6)));
              case 1:
                return formatter.format(Today.add(Duration(days: -5)));
              case 2:
                return formatter.format(Today.add(Duration(days: -4)));
              case 3:
                return formatter.format(Today.add(Duration(days: -3)));
              case 4:
                return formatter.format(Today.add(Duration(days: -2)));
              case 5:
                return formatter.format(Today.add(Duration(days: -1)));
              case 6:
                return formatter.format(Today);
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            return value.toInt().toString();
          },
          interval: 5,
          reservedSize: 35,
          margin: 12,
        ),
      );
    }
    //pressure
    else if( this.type == 2){
      String name = 'Pressure';
      return FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 35,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff68737d),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return formatter.format(Today.add(Duration(days: -6)));
              case 1:
                return formatter.format(Today.add(Duration(days: -5)));
              case 2:
                return formatter.format(Today.add(Duration(days: -4)));
              case 3:
                return formatter.format(Today.add(Duration(days: -3)));
              case 4:
                return formatter.format(Today.add(Duration(days: -2)));
              case 5:
                return formatter.format(Today.add(Duration(days: -1)));
              case 6:
                return formatter.format(Today);
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            return value.toInt().toString();
          },
          interval: 200,
          reservedSize: 35,
          margin: 12,
        ),
      );
    }
    //particle
    else if( this.type == 3){
      return FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 35,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff68737d),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return formatter.format(Today.add(Duration(days: -6)));
              case 1:
                return formatter.format(Today.add(Duration(days: -5)));
              case 2:
                return formatter.format(Today.add(Duration(days: -4)));
              case 3:
                return formatter.format(Today.add(Duration(days: -3)));
              case 4:
                return formatter.format(Today.add(Duration(days: -2)));
              case 5:
                return formatter.format(Today.add(Duration(days: -1)));
              case 6:
                return formatter.format(Today);
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            return value.toInt().toString();
          },
          interval: 5,
          reservedSize: 35,
          margin: 12,
        ),
      );
    }
    //oxidation
    else if( this.type == 4){
      return FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 35,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff68737d),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return formatter.format(Today.add(Duration(days: -6)));
              case 1:
                return formatter.format(Today.add(Duration(days: -5)));
              case 2:
                return formatter.format(Today.add(Duration(days: -4)));
              case 3:
                return formatter.format(Today.add(Duration(days: -3)));
              case 4:
                return formatter.format(Today.add(Duration(days: -2)));
              case 5:
                return formatter.format(Today.add(Duration(days: -1)));
              case 6:
                return formatter.format(Today);
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            return value.toInt().toString();
          },
          interval: 5,
          reservedSize: 35,
          margin: 12,
        ),
      );
    }
    //reduction
    else if( this.type == 5){
      return FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 35,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff68737d),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return formatter.format(Today.add(Duration(days: -6)));
              case 1:
                return formatter.format(Today.add(Duration(days: -5)));
              case 2:
                return formatter.format(Today.add(Duration(days: -4)));
              case 3:
                return formatter.format(Today.add(Duration(days: -3)));
              case 4:
                return formatter.format(Today.add(Duration(days: -2)));
              case 5:
                return formatter.format(Today.add(Duration(days: -1)));
              case 6:
                return formatter.format(Today);
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            return value.toInt().toString();
          },
          interval: 5,
          reservedSize: 35,
          margin: 12,
        ),
      );
    }
    //ammonia
    else if( this.type == 6){
      return FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 35,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff68737d),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return formatter.format(Today.add(Duration(days: -6)));
              case 1:
                return formatter.format(Today.add(Duration(days: -5)));
              case 2:
                return formatter.format(Today.add(Duration(days: -4)));
              case 3:
                return formatter.format(Today.add(Duration(days: -3)));
              case 4:
                return formatter.format(Today.add(Duration(days: -2)));
              case 5:
                return formatter.format(Today.add(Duration(days: -1)));
              case 6:
                return formatter.format(Today);
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            return value.toInt().toString();
          },
          interval: 5,
          reservedSize: 35,
          margin: 12,
        ),
      );
    }
    else{
      return FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 35,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff68737d),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return formatter.format(Today.add(Duration(days: -6)));
              case 1:
                return formatter.format(Today.add(Duration(days: -5)));
              case 2:
                return formatter.format(Today.add(Duration(days: -4)));
              case 3:
                return formatter.format(Today.add(Duration(days: -3)));
              case 4:
                return formatter.format(Today.add(Duration(days: -2)));
              case 5:
                return formatter.format(Today.add(Duration(days: -1)));
              case 6:
                return formatter.format(Today);
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10k';
              case 3:
                return '30k';
              case 5:
                return '50k';
            }
            return '';
          },
          reservedSize: 35,
          margin: 12,
        ),
      );
    }
  }
}
