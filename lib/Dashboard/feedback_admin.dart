import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FeedbackAdmin extends StatefulWidget {
  const FeedbackAdmin({super.key});

  @override
  State<FeedbackAdmin> createState() => _FeedbackAdminState();
}

class _FeedbackAdminState extends State<FeedbackAdmin> {

  String type = "pending";
  final TextEditingController adminAnswer = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Feedback"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  GestureDetector(
                    onTap: (){
                      setState(() {
                        type = "pending";
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: type == 'pending' ? Colors.red.shade300 : Colors.transparent,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: const Text("Pending", style: TextStyle(color: Colors.red),),
                    ),
                  ),

                  GestureDetector(
                    onTap: (){
                      setState(() {
                        type = "answered";
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                          color: type == 'answered' ? Colors.green.shade300 : Colors.transparent,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: const Text("Answered", style: TextStyle(color: Colors.green),),
                    ),
                  ),

                ],
              ),
            ),

            StreamBuilder(
                stream: type == 'pending' ? FirebaseFirestore.instance.collection("Feedback").where('adminAnswer',isEqualTo: 'pending').snapshots() : FirebaseFirestore.instance.collection("Feedback").snapshots(),
                builder: (BuildContext context,  snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data!.docs.length != 0 ? ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const ScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(snapshot.data!.docs[index]['userFeedback']),
                          subtitle: Text('Admin: ${snapshot.data!.docs[index]['adminAnswer']}'),
                          trailing: IconButton(onPressed: (){
                            showDialog<void>(
                              context: context,
                              // false = user must tap button, true = tap outside dialog
                              builder:
                                  (BuildContext dialogContext) {
                                return AlertDialog(
                                  title: const Text('Feedback Answer'),
                                  content: TextFormField(
                                    controller: adminAnswer,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder()
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Update'),
                                      onPressed: () async{
                                        await FirebaseFirestore.instance.collection("Feedback").doc(snapshot.data!.docs[index].id).update({
                                          "adminAnswer" : adminAnswer.text
                                        });
                                        Navigator.of(
                                            dialogContext)
                                            .pop(); // Dismiss alert dialog
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }, icon: const Icon(Icons.edit,color: Colors.blue,)),
                        );
                      },): const Center(child: Text("No Query Left"));
                  } else if (snapshot.hasError) {
                    return const Icon(Icons.error_outline);
                  } else {
                    return const CircularProgressIndicator();
                  }
                })

          ],
        ),
      ),
    );
  }
}
