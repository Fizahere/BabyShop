import 'package:baby_shop/ClientSite/cart_screen.dart';
import 'package:baby_shop/ClientSite/product_detail.dart';
import 'package:baby_shop/Dashboard/product.dart';
import 'package:baby_shop/Dashboard/users.dart';
import 'package:flutter/material.dart';
import '../ClientSite/UserInfo.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {

  int currentIndex = 0;

  void pageShifter(index){
    setState(() {
      currentIndex = index;
    });
  }

  List myScreens = <Widget>[
    const Users(),
    const Product(),
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
          BottomNavigationBarItem(icon: Icon(Icons.category),label: "Users"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: "Product"),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile"),
        ],
      ),
    );
  }
}
