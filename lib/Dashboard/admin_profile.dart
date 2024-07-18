import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Auth/Login.dart';

class AdminProfile extends StatefulWidget {
  const AdminProfile({super.key});

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Container(
            height: 570,
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.blue, // Customize as per your design
                    radius: 30,
                    child: Text(
                      'A', // Display first letter of name
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Text(
                              "Name: ",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            Text(
                            'Admin',
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Row(
                          children: [
                            Text(
                              "Contact: ",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            Text(
                             'admin@gmail.com',
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: ()async{
                            await FirebaseAuth.instance.signOut();
                            SharedPreferences userCred = await SharedPreferences.getInstance();
                            userCred.clear();
                            Navigator.push(context,  MaterialPageRoute(builder: (context) => const LoginForm(),));
                          },
                          child: const Row(
                            children: [
                              Text('Logout',style: TextStyle(color:Colors.red,fontSize: 17),),
                              SizedBox(width: 10),
                            Icon(Icons.logout,size: 20,color: Colors.red,)
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
