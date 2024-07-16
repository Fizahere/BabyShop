import 'dart:async';

import 'package:baby_shop/Auth/Login.dart';
import 'package:baby_shop/ClientSite/Home.dart';
import 'package:baby_shop/ClientSite/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ClientSite/product_detail.dart';
import 'Dashboard/product.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent.shade100),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String userEmail = "";

  Future getUserData()async{
    SharedPreferences userCred = await SharedPreferences.getInstance();
    var uEmail = userCred.getString("email");
    return uEmail;
  }

  @override
  void initState() {
    // TODO: implement initState
    getUserData().then((value) {
      if(value != null){
        Timer(const Duration(milliseconds: 2000), () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Home(),)));
      }
      else{
        Timer(const Duration(milliseconds: 2000), () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Product(),)));
      }
    },);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Container(
        child: Image.asset('images/logo.png',height: 110,),
      )),
    );
  }
}
