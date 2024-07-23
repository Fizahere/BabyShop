import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class FeedBackScreen extends StatefulWidget {
  const FeedBackScreen({super.key});

  @override
  State<FeedBackScreen> createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {

  final TextEditingController userFeedback = TextEditingController();

  String uEmail = "";

  Future getUser()async{
    SharedPreferences userCred = await SharedPreferences.getInstance();
    var userEmail = userCred.getString("email");
    return userEmail;
  }

  @override
  void initState() {
    // TODO: implement initState
    getUser().then((value){
      setState(() {
        uEmail = value;
      });
    });
    super.initState();
  }

  void sendFeedback()async{
    try{
      String feedBackID = const Uuid().v1();
      Map<String, dynamic> share = {
        "feedBackID" : feedBackID,
        "userEmail" : uEmail,
        "userFeedback" : userFeedback.text,
        "adminAnswer" : "pending"
      };
      await FirebaseFirestore.instance.collection("Feedback").doc(feedBackID).set(share);
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("FeedBack Shared")));
      }
    }catch(ex){
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Error Occured")));
      }
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FeedBack Screen"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10,),

              SizedBox(
                width: double.infinity,
                child: TextFormField(
                  controller: userFeedback,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                ),
              ),

              const SizedBox(height: 10,),

              ElevatedButton(onPressed: (){
                sendFeedback();
              }, child: const Text("Send")),

              const SizedBox(height: 10,),

              Container(
                margin: const EdgeInsets.only(left: 10),
                child: const Text("Your FeedBacks"),
              ),

              StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("Feedback").where('userEmail',isEqualTo: uEmail).snapshots(),
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
                            trailing: IconButton(onPressed: ()async{
                              await FirebaseFirestore.instance.collection("Feedback").doc(snapshot.data!.docs[index].id).delete();
                            }, icon: const Icon(Icons.delete,color: Colors.red,)),
                          );
                        },): const Center(child: Text("Ask Any Query"));
                    } else if (snapshot.hasError) {
                      return const Icon(Icons.error_outline);
                    } else {
                      return const CircularProgressIndicator();
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
