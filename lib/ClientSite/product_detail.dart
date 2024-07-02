import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  List productDetailImages=[
    'images/Slider1.jpg',
    'images/Slider2.jpg',
    'images/Slider3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    List reviews = [
      {'name': 'Fiza', 'location': 'Karachi', 'review': 'Great product!'},
      {'name': 'Laiba', 'location': 'Karachi', 'review': 'Pretty good overall.'},
      {'name': 'Ali', 'location': 'Karachi', 'review': 'Not worth the price.'},
      {'name': 'Ali', 'location': 'Karachi', 'review': 'Not worth the price.'},
    ];
    int reviewCount = reviews.length;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(items: List.generate(productDetailImages.length, (index) => Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                // height: 300,
                // width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(productDetailImages[index]))
                ),
                // color: Colors.red,
              )),
                  options: CarouselOptions(
                    height: 300,
                    viewportFraction: 1
                  )),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Clothes',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  Text('\$ 980',style: TextStyle(fontSize: 15,color: Colors.green),),
                ],
              ),
              SizedBox(height: 10,),
              Text('Strongest matches. characterization, confession, definition, depiction, detail, explanation, information, narration, narrative, picture, portrayal, report, sketch, statement, story, summary, tale, version.'
                ,style: TextStyle(fontSize: 12,),),
              SizedBox(height: 20,),
              Center(
                child: Text('Reviews ($reviewCount)'
                  ,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
              ),
              SizedBox(height: 10,),
              ...reviews.map((review) => Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                ),
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        review['name']!,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        review['location']!,
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      Expanded(
                        child: Text(review['review']!),
                      ),
                    ],
                  ),
                ),
              )).toList(),

            ],
          ),
        ),
      ),
    );
  }
}
