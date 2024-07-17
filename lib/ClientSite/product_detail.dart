import 'package:baby_shop/ClientSite/UserInfo.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productID;

  const ProductDetailScreen({Key? key, required this.productID}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int count = 1;
  double price = 70.0;
  double totalPrice = 70.0;
  List productDetailImages = [
    'images/Slider1.jpg',
    'images/Slider2.jpg',
    'images/Slider3.jpg',
  ];
  List reviews = [
    {'name': 'Fiza', 'location': 'Karachi', 'review': 'Great product!'},
    {'name': 'Laiba', 'location': 'Karachi', 'review': 'Pretty good overall.'},
    {'name': 'Ali', 'location': 'Karachi', 'review': 'Not worth the price.'},
    {'name': 'Ali', 'location': 'Karachi', 'review': 'Not worth the price.'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Products').where("ProductID", isEqualTo: widget.productID).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            var doc = snapshot.data!.docs.first;
            String productName = doc['Name'];
            String productDescription = doc['Description'];
            String productCategory = doc['Category'];
            String productPrice = doc['Price'];
            String productImage = doc['Image'];

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
Container(
  child: Image.network(
    productImage,
    height: 140,
    width: 140,
    fit: BoxFit.cover, // Adjust the fit as per your requirement
    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
      return Center(
        child: Text('Image not available'),
      );
    },
  ),
),
                    SizedBox(height: 15),
                    Text(
                      productName,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      productDescription,
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  count += 1;
                                  totalPrice = price * count;
                                });
                              },
                              child: Text('+'),
                            ),
                            Text('$count'),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  if (count > 1) {
                                    count -= 1;
                                    totalPrice = price * count;
                                  } else {
                                    count == 1;
                                  }
                                });
                              },
                              child: Text(
                                '-',
                                style: TextStyle(fontSize: 25),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '\$ $totalPrice',
                          style: TextStyle(fontSize: 15, color: Colors.green),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 350,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => UserInfo()));
                        },
                        child: Text(
                          'Checkout',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Text(
                        'Reviews (${reviews.length})',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 330,
                      height: 40,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty || value.trim().isEmpty) {
                            return "Fill the field!";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
                          labelText: 'Your review...',
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.send),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    ...reviews.map(
                          (review) => Container(
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
                      ),
                    ).toList(),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: Text('No product found'));
          }
        },
      ),
    );
  }
}
