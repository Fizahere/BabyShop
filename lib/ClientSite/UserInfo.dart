import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../Auth/Register.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {

  final TextEditingController name=TextEditingController();
  final TextEditingController contact=TextEditingController();
  final TextEditingController address=TextEditingController();
  List viewers=['Paypal','Cash on delivery'];
  dynamic defaulVal='Cash on delivery';

  String uEmail = "";

  Future getUserEmail()async{
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

  void addUser()async{
    String UserId = const Uuid().v1();
    try{
      await FirebaseFirestore.instance.collection("userInfo").doc(UserId).set({
        "PostID" : UserId,
        "Name" : name.text,
        "Contact" : contact.text,
        "Address" : address.text,
        "Payment" : defaulVal,
        "userEmail" : uEmail
      });

      Navigator.push(context,MaterialPageRoute(builder:(context)=>const SignUpForm()));
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Account Created"))); // stf
    } catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color(0xFFF0F0F0),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 75,horizontal: 35),
          child: Container(
            color: Colors.white,
            child: Form(
              key: formKey,
                child:Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Image.asset('images/logo.png',height: 140,width: 140,),
                      TextFormField(
                        controller: name,
                        validator: (value){
                          if(value == null || value.isEmpty || value == " "){
                            return "Name is Requried";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          label: Text('Name**'),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(validator: (value){
                        if(value == null || value.isEmpty || value == " "){
                          return "Contact is Requried";
                        }
                        return null;
                      },
                        controller: contact,
                        decoration: const InputDecoration(
                          label: Text('Phone**'),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        controller: address,
                        validator: (value){
                          if(value == null || value.isEmpty || value == " "){
                            return "Address is Requried";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          label: Text('Address**'),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      DropdownButton(
                          value: defaulVal,
                          items: viewers.map((value) {
                            return DropdownMenuItem(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(), onChanged: (val){
                        setState((){
                          defaulVal=val;
                        });
                        // debugPrint(defaulVal);
                      }),                      const SizedBox(height: 40,),
ElevatedButton(
    onPressed: (){
     if(formKey.currentState!.validate()){
       addUser();
     }
},style: ButtonStyle(
backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
                ), child: const Text('Continue',style: TextStyle(color: Colors.white),
),
)
                    ],
                  ),
                )
            ),
          ),
        ),
      ),
    );
  }
}
