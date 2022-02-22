import 'package:flutter/material.dart';

//widget imports
import 'package:food_waste/widgets/navdrawer.dart';

//other imports
import 'package:carousel_slider/carousel_slider.dart';


class wasteawareness extends StatefulWidget {
  const wasteawareness({Key? key}) : super(key: key);

  @override
  State<wasteawareness> createState() => _wasteawareness();
}

class _wasteawareness extends State<wasteawareness> {

  List<String> listOfPics= ['assets/images/awareness1.png', 'assets/images/awareness2.png'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: navdrawer(),
      appBar: AppBar(
        title: const Text('Food Waste Awareness'),
      ),
      body: CarouselSlider(
        options: CarouselOptions(height: double.infinity),
        items: listOfPics.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                  ),
                  child: Image.asset('$i'),
              );
            },
          );
        }).toList(),
      )
    );
  }

}