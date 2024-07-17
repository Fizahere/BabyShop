import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController name= TextEditingController();
  final TextEditingController email= TextEditingController();
  final TextEditingController contact = TextEditingController();
  final TextEditingController address= TextEditingController();
  List values=['paypal','cash on delivery'];
  dynamic defaulVal='paypal';

  void updatedata(String PostID)async{
    try {
      await FirebaseFirestore.instance.collection("userInfo")
          .doc(PostID)
          .update({
        "Address": name.text,
        "Contact": contact.text,
        "Name": name.text,
        "Payment": defaulVal
      });
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Edited"),));
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:const Color(0xFFF0F0F0),
        body:StreamBuilder(
          stream: FirebaseFirestore.instance.collection("userInfo").snapshots(),
          builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(),);
            }
            if(snapshot.hasData){
              var dataLenght = snapshot.data!.docs.length;
              return dataLenght != 0 ? ListView.builder(
                  itemCount: dataLenght,
                  itemBuilder:(context, index){
                    String Address = snapshot.data!.docs[index]["Address"];
                    String Contact = snapshot.data!.docs[index]["Contact"];
                    String Name = snapshot.data!.docs[index]["Name"];
                    String UserID = snapshot.data!.docs[index]["PostID"];
                    String Payment = snapshot.data!.docs[index]["Payment"];
                    return  Column(
                        children: [
                          const CircleAvatar(
                            radius: 60,
                          ),
                          const SizedBox(height: 10,),

                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  elevation: 0,
                                  context: context, builder: (context){
                                return StatefulBuilder(builder: (context,setState){
                                  return SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(bottom: 10.0,),
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                  color: Colors.black,
                                                  width: 2.0,
                                                ),
                                              ),
                                            ),
                                            child: const Text(
                                              "Edit",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          const SizedBox(height: 25,),
                                          TextFormField(
                                            controller: name,

                                            validator: (val) {
                                              if (val == " " || val != null) {
                                                return "Fill the Field";
                                              }
                                              return null;
                                            },
                                            decoration: const InputDecoration(
                                                hintText: "Enter Name"
                                            ),
                                          ),

                                          TextFormField(
                                            controller: contact,
                                            validator: (val){
                                              if (val == " " || val != null) {
                                                return "Fill the Field";
                                              }
                                              return null;
                                            },
                                            decoration: const InputDecoration(
                                                hintText: "Enter Contact"
                                            ),                                      ),

                                          TextFormField(
                                            controller: address,
                                            validator: (val) {
                                              if (val == " " || val != null) {
                                                return "Fill the Field";
                                              }
                                              return null;
                                            },
                                            decoration: const InputDecoration(
                                                hintText: "Enter Address"
                                            ),                                      ),

                                          const SizedBox(height: 20,),
                                          Row(

                                            children: [

                                              const Text('payment method:',
                                                  style:TextStyle(
                                                      fontSize: 16
                                                  )),
                                              const SizedBox(width: 4,),
                                              DropdownButton(
                                                  value: defaulVal,
                                                  items: values.map((value) {
                                                    return DropdownMenuItem(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(), onChanged: (val){
                                                setState((){
                                                  defaulVal=val;
                                                });
                                                // debugPrint(defaulVal);
                                              }),
                                            ],
                                          ),
                                          const SizedBox(height: 30,),
                                          ElevatedButton(
                                            onPressed: () {
                                              updatedata(UserID);
                                              // addPost();
                                              // print('posted');
                                            },
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                            ),child: const Center(
                                            child: Text(

                                              'Edit',
                                              style: TextStyle(color: Colors.white),

                                            ),
                                          ),)
                                        ],
                                      ),
                                    ),
                                  );
                                });
                              });
                              const SizedBox(height: 23);
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Text("Name: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                                          Text(Name,style: const TextStyle(fontSize: 17)),
                                        ],
                                      ),
                                      const SizedBox(height: 20,),

                                      Row(
                                        children: [
                                          const Text("Address: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                                          Text(Address,style: const TextStyle(fontSize: 17)),
                                        ],
                                      ),
                                      const SizedBox(height: 20,),

                                      Row(
                                        children: [
                                          const Text("Contact: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                                          Text(Contact,style: const TextStyle(fontSize: 17)),
                                        ],
                                      ),
                                      const SizedBox(height: 20,),

                                      Row(
                                        children: [
                                          const Text("Payment: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                                          Text(Payment,style: const TextStyle(fontSize: 17)),
                                        ],
                                      ),

                                    ],
                                  ),
                                ],
                              );
                            },
                          )
                        ]);}
              ): const Center(child: Text("Nothing to show"),);

            }
            return Container();
          },
        )
    );
  }
}
