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
              case 0:
                return '0°C';
              case 5:
                return '5°C';
              case 10:
                return '10°C';
              case 15:
                return '15°C';
              case 20:
                return '20°C';
              case 25:
                return '25°C';
            }
            return '';
          },
          reservedSize: 50,
          margin: 10,
        ),
      );
    }
    //humidity
    else if( this.type == 1){
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
              case 0:
                return '0';
              case 25:
                return '25';
              case 50:
                return '50';
            }
            return '';
          },
          reservedSize: 35,
          margin: 12,
        ),
      );
    }
    //pressure
    else if( this.type == 2){
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
              case 0:
                return '0';
              case 750:
                return '750';
              case 1500:
                return '1500';
            }
            return '';
          },
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
            switch (value.toInt()) {
              case 1:
                return '1';
              case 5:
                return '5';
              case 10:
                return '10';
            }
            return '';
          },
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
            switch (value.toInt()) {
              case 0:
                return '0';
              case 25:
                return '25';
              case 50:
                return '50';
            }
            return '';
          },
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
            switch (value.toInt()) {
              case 0:
                return '0';
              case 250:
                return '250';
              case 500:
                return '500';
            }
            return '';
          },
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
            switch (value.toInt()) {
              case 0:
                return '0';
              case 150:
                return '150';
              case 300:
                return '300';
            }
            return '';
          },
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
