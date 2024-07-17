import 'package:flutter/material.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(9.0),
              child: Center(
                child: Column(
                  children: [
                    Text('About',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
                    Text('Baby Shop',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
          Image.asset('images/carousel2.jpg'),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Welcome to Baby Shop Hub, your one-stop destination for all your baby\'s needs! At Baby Shop Hub, we understand the joys and challenges of parenthood, and we strive to make your journey as smooth and enjoyable as possible.',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Image.asset('images/about1.jpg', height: 230,),
                  Expanded(
                    child: Column(
                      children: [
                        Text('Style',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        SizedBox(height: 10,),
                        Text(
                          'Our curated selection of baby products, from clothing and accessories to toys and nursery essentials, is designed to provide the best for your little ones.',
                          textAlign: TextAlign.center,  style: TextStyle(fontWeight: FontWeight.bold),

                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text('Quality',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        SizedBox(height: 10,),
                        Text(
                          'We are committed to offering high-quality, safe, and stylish items that cater to both babies and parents.',
                          textAlign: TextAlign.center,   style: TextStyle(fontWeight: FontWeight.bold),

                        ),
                      ],
                    ),
                  ),
                  Image.asset('images/about2.jpg', height: 240,),
                ],
              ),
            ),
            Text(
              '© 2024 Baby Shop Hub. All rights reserved. | made by Fiza.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
