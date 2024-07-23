import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String uEmail = "";

  Future getUserEmail() async {
    SharedPreferences userCred = await SharedPreferences.getInstance();
    var userEmail = userCred.getString("email");
    return userEmail;
  }

  @override
  void initState() {
    // TODO: implement initState
    getUserEmail().then((value) {
      setState(() {
        uEmail = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Cart")
              .where("userEmail", isEqualTo: uEmail)
              .snapshots(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              var dataLength = snapshot.data!.docs.length;
              return dataLength != 0
                  ? ListView.builder(
                      itemCount: dataLength,
                      itemBuilder: (context, index) {
                        var cartID = snapshot.data!.docs[index].id;
                        String pName =
                            snapshot.data!.docs[index]["productName"];
                        String pImage =
                            snapshot.data!.docs[index]["productImage"];
                        String pPrice =
                            snapshot.data!.docs[index]["productPrice"];
                        // String pDesc = snapshot.data!.docs[index]["productDesc"];
                        String pQuantity =
                            snapshot.data!.docs[index]["productQuantity"];
                        // String pID = snapshot.data!.docs[index]["productID"];

                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(pImage),
                          ),
                          title: Text(pName),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text(pID),
                              Text(pQuantity),
                              Text(pPrice),
                            ],
                          ),
                          trailing: IconButton(
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection("Cart")
                                    .doc(cartID)
                                    .delete();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Cart deleted")));
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              )),
                        );
                      },
                    )
                  : const Center(child: Text("No item in cart"));
            } else if (snapshot.hasError) {
              return const Center(child: Icon(Icons.error_outline));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
