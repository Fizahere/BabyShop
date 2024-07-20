import 'package:baby_shop/ClientSite/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Dashboard/admin_home.dart';
import '../components/loader.dart';
import 'Register.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  TextEditingController userEmail=TextEditingController();
  TextEditingController userPassword=TextEditingController();

  bool _obscureText = true;
  bool signupLoading = false;

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
                child:Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Image.asset('images/logo.png',height: 140,width: 140,),
                      TextFormField(
                        controller: userEmail,
                        decoration: const InputDecoration(
                          label: Text('Email**'),
                          suffixIcon: Icon(Icons.email_outlined,),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        controller: userPassword,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40,),
                      ElevatedButton(
                        onPressed: () async {
                          String uEmail = userEmail.text;
                          String uPassword = userPassword.text;
                          try {
                            signupLoading=true;
                            await FirebaseAuth.instance.signInWithEmailAndPassword(
                                email: uEmail, password: uPassword);
                            SharedPreferences userCred = await SharedPreferences.getInstance();
                            userCred.setString("email", userEmail.text);
                            if(uEmail=='admin@gmail.com'){
                            if(context.mounted){
                              Navigator.push(context,MaterialPageRoute(builder:(context)=>const AdminHome()));
                            }
                            }
                            else{
                                  if(context.mounted) {
                                    Navigator.push(
                                        context, MaterialPageRoute(builder: (context) => const Home()));
                                  }    }
                            signupLoading=false;
                            if(context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('logged in'),
                                ),
                              );
                            }
                          }on FirebaseAuthException catch (e) {
                            signupLoading=false;
                            if(context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(e.toString()),
                                ),
                              );
                            }
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurpleAccent),
                        ),
                        child: Center(
                          child: signupLoading ? Loader()
                              :
                          const Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5,),
                      const Text("Don't have an account?",),
GestureDetector(
  onTap:(){
    Navigator.push(context,MaterialPageRoute(builder:(context)=>const SignUpForm()));
  },
  child:const Text('Signup',style: TextStyle(color: Colors.blue),)
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
