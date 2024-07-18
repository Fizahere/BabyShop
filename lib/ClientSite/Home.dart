import 'package:baby_shop/ClientSite/cart_screen.dart';
import 'package:baby_shop/ClientSite/home_screen.dart';
import 'package:baby_shop/ClientSite/product_detail.dart';
import 'package:baby_shop/ClientSite/profile_screen.dart';
import 'package:flutter/material.dart';

import 'UserInfo.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int currentIndex = 0;

  void pageShifter(index){
    setState(() {
      currentIndex = index;
    });
  }

  List myScreens = <Widget>[
    const HomeScreen(),
    const ProductDetailScreen(),
    const CartScreen(),
    const UserInfo()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myScreens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.grey.shade400,
        showUnselectedLabels: true,
        currentIndex: currentIndex,
        onTap: pageShifter,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.category),label: "Product"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile"),
        ],
      ),
    );
  }
}
