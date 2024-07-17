import 'package:baby_shop/Dashboard/admin_profile.dart';
import 'package:baby_shop/Dashboard/chart.dart';
import 'package:baby_shop/Dashboard/product.dart' as productsData;
import 'package:baby_shop/Dashboard/users.dart';
import 'package:flutter/material.dart';

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
    ProductsUsersChart(),
    const Users(),
    const productsData.Product(),
    const AdminProfile(),
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
          BottomNavigationBarItem(icon: Icon(Icons.people),label: "Users"),
          BottomNavigationBarItem(icon: Icon(Icons.category),label: "Product"),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile"),
        ],
      ),
    );
  }
}
