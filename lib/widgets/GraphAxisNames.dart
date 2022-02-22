import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LineTitles {

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
              case 2:
                return '2°C';
              case 4:
                return '4°C';
              case 6:
                return '6°C';
              case 8:
                return '8°C';
              case 10:
                return '10°C';
            }
            return '';
          },
          reservedSize: 50,
          margin: 10,
        ),
      );
    }
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
