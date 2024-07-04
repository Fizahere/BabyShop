import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
List sliderImages=[
  'images/Slider1.jpg',
  'images/Slider2.jpg',
  'images/Slider3.jpg',
];

List tabs = [ "Clothing", "Toys", "Baby food", "Diapers","Care Products"];
int current = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Image.asset('images/logo.png',height: 150,width: 150,),),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(items: List.generate(sliderImages.length, (index) => Container(
            margin: EdgeInsets.symmetric(horizontal: 2),
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(sliderImages[index]))
              ),
              // color: Colors.red,
            )),
                options: CarouselOptions(
                  autoPlay: true,
                  viewportFraction: 0.80,
                  height: 180,
                  aspectRatio: 1,
                  enlargeCenterPage: true,
                )),
        
            SizedBox(height: 10,),
            
            Container(
              height: 30,
              child: Expanded(child: ListView.builder(
                itemCount: tabs.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    setState(() {
                      current = index;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    padding: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border:
                  Border( bottom: BorderSide(color: current == index ? Colors.black: Colors.transparent),
                    ),),
                    child: Text(tabs[index]),
                  ),
                );
              },)),
            ),
            SizedBox(height: 10,),
            Grid(),
          ],
        ),
      )
    );
  }
}
