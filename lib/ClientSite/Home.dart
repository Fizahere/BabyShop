import 'package:baby_shop/ClientSite/cart_screen.dart';
import 'package:baby_shop/ClientSite/home_screen.dart';
import 'package:baby_shop/ClientSite/user_profile.dart';
import 'package:flutter/material.dart';

import 'About.dart';

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
    const About(),
    const CartScreen(),
    const UserProfile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myScreens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.deepPurpleAccent,
        unselectedItemColor: Colors.grey.shade400,
        showUnselectedLabels: true,
        currentIndex: currentIndex,
        onTap: pageShifter,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.info),label: "About"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile"),
        ],
      ),
    );
  }
}
