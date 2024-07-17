import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  // String userId = '';
  // Map<String, dynamic>? userData = {}; // Initialize as empty map
  //
  // @override
  // void initState() {
  //   super.initState();
  //   fetchUserData();
  // }

  // void fetchUserData() async {
  //   SharedPreferences userCred = await SharedPreferences.getInstance();
  //   userId = userCred.getString("userId") ?? '';
  //
  //   if (userId.isNotEmpty) {
  //     try {
  //       DocumentSnapshot<Map<String, dynamic>> snapshot =
  //       await FirebaseFirestore.instance.collection("userInfo").doc(userId).get();
  //
  //       if (snapshot.exists) {
  //         setState(() {
  //           userData = snapshot.data();
  //         });
  //       }
  //     } catch (e) {
  //       print("Error fetching user data: $e");
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F0F0),
      body:  SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Container(
            height: 570,
            color: Colors.white,
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    child: Text(
                      'F', // Display first letter of name
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    backgroundColor: Colors.blue, // Customize as per your design
                    radius: 30,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Name: ",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            Text(
                              'Fiza',
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              "Contact: ",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            Text(
                              '0321323212',
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              "Address: ",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            Text(
                              'Karachi, Pakistan',
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              "Payment Method: ",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            Text(
                              'Paypal',
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),

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
