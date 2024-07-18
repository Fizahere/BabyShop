import 'package:baby_shop/Auth/Login.dart';
import 'package:baby_shop/ClientSite/product_detail.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
List sliderImages=[
  'images/Slider1.jpg',
  'images/Slider2.jpg',
  'images/Slider3.jpg',
];

List tabs = [ "Clothing", "Toys", "Baby food", "Diapers","Care Products"];
int current = 0;

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
    setState(() {
      userEmail = value;
    });
  });  
  super.initState();
  }


@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userEmail),
      automaticallyImplyLeading: false,
       actions: [
         IconButton(onPressed: ()async{
           await FirebaseAuth.instance.signOut();
           SharedPreferences userCred = await SharedPreferences.getInstance();
           userCred.clear();
           Navigator.push(context,  MaterialPageRoute(builder: (context) => const LoginForm(),));
         }, icon: const Icon(Icons.logout))
       ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(items: List.generate(sliderImages.length, (index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(sliderImages[index]))
              ),
              // color: Colors.red,
            )),
                options: CarouselOptions(
                  autoPlay: true,
                  viewportFraction: 0.80,
                  height: 180,
                  aspectRatio: 1,
                  enlargeCenterPage: true,
                )),
        
            const SizedBox(height: 10,),
            
            Container(
              height: 30,
              child: Expanded(child: ListView.builder(
                itemCount: tabs.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    setState(() {
                      current = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border:
                  Border( bottom: BorderSide(color: current == index ? Colors.black: Colors.transparent),
                    ),),
                    child: Text(tabs[index]),
                  ),
                );
              },)),
            ),
            const SizedBox(height: 10,),
            StreamBuilder(
                stream: current ==  0 ? FirebaseFirestore.instance.collection('Products').where("Category",isEqualTo: "Clothing").snapshots() :
                current == 1 ? FirebaseFirestore.instance.collection('Products').where("Category",isEqualTo: "Category").snapshots() :
                current == 2 ? FirebaseFirestore.instance.collection('Products').where("Category",isEqualTo: "Category").snapshots() :
                current == 3 ? FirebaseFirestore.instance.collection('Products').where("Category",isEqualTo: "Category").snapshots() :
                FirebaseFirestore.instance.collection('Products').where("Category",isEqualTo: "Category").snapshots(),
                builder: (BuildContext context,snapshot){
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator());
                  }
                  if(snapshot.hasData){
                    var docsLength= snapshot.data?.docs.length;
                    return docsLength !=0 ? ListView.builder(
                        itemCount: docsLength,
                        shrinkWrap: true,
                        itemBuilder: (context,index){
                          String productName=snapshot.data?.docs[index]['Name'];
                          String productDescription=snapshot.data?.docs[index]['Description'];
                          String productCategory=snapshot.data?.docs[index]['Category'];
                          String productPrice=snapshot.data?.docs[index]['Price'];
                          String productImage=snapshot.data?.docs[index]['Image'];
                          return       GridView.count(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            crossAxisCount: 2,
                            children: List.generate(docsLength!, (index) {
                              return GestureDetector(
                                onTap:(){
                                  Navigator.push(context,MaterialPageRoute(builder:(context)=>ProductDetailScreen()));
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      height: 140,
                                      width: 140,
                                      margin: EdgeInsets.all(4),

                                      child: Image.network(productImage),
                                      decoration: BoxDecoration(
                                          color: Colors.deepPurpleAccent.shade100,
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(productName,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                        Text(productPrice,style: TextStyle(fontSize: 14,color: Colors.green),),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }),
                          );
                        })
                        : Center(child: Text('no products found'),);
                  };
                  if(snapshot.hasError){
                    return Center(child: Icon(Icons.error,color: Colors.red,),);
                  }
                  return Container();
                }
            ),
            // Grid(),
          ],
        ),
      )
    );
  }
}
