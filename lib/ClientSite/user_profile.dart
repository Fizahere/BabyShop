import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String? userEmail;
  Future getUserEmail()async{
    SharedPreferences userCred = await SharedPreferences.getInstance();
    var uEmail = userCred.getString("email");
    return uEmail;
  }
  @override
  void initState() {
    // TODO: implement initState
    getUserEmail().then((value) {
      setState(() {
        userEmail = value;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      body:  StreamBuilder(stream: FirebaseFirestore.instance.collection("userInfo").where("userEmail",isEqualTo: userEmail).snapshots(), builder: (context, snapshot) {
       
        if(snapshot.connectionState == ConnectionState.waiting){}
        
        if(snapshot.hasData){
          var dataLength = snapshot.data!.docs.length;
          return ListView.builder(
            itemCount: dataLength,
            itemBuilder: (context, index) {
              String userName = snapshot.data!.docs[index]["Name"];
              String userAddress = snapshot.data!.docs[index]["Address"];
              String userPayment = snapshot.data!.docs[index]["Payment"];
              String userContact = snapshot.data!.docs[index]["Contact"];
            return SingleChildScrollView(
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
                          'F', // Display first letter of name
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
                            Row(
                              children: [
                                const Text(
                                  "Name: ",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                                ),
                                Text(
                                  userName,
                                  style: const TextStyle(fontSize: 17),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                const Text(
                                  "Contact: ",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                                ),
                                Text(
                                  userContact,
                                  style: const TextStyle(fontSize: 17),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                const Text(
                                  "Address: ",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                                ),
                                Text(
                                  userAddress,
                                  style: const TextStyle(fontSize: 17),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                const Text(
                                  "Payment Method: ",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                                ),
                                Text(
                                  userPayment,
                                  style: const TextStyle(fontSize: 17),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
          },);
        }
        
        if(snapshot.hasError){
          return const Center(child: Icon(Icons.error,color: Colors.red,),);
        }
       
        return Container();
      },),
    );
  }
}
