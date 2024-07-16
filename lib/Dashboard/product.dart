import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../components/table.dart';

class Product extends StatefulWidget {
  const Product({super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  final TextEditingController name=TextEditingController();
  final TextEditingController price=TextEditingController();
  final TextEditingController description=TextEditingController();
  List categories=['Clothing','Shoes','Toys'];
  dynamic defaulVal='Clothing';

  void addProductWithImage() async {
    String productID = Uuid().v1();
    if (kIsWeb) {
      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child("productImage")
          .child(productID)
          .putData(productImage);
      TaskSnapshot taskSnapshot = await uploadTask;
      String productImageUrl = await taskSnapshot.ref.getDownloadURL();
      addProduct(productID, productImageUrl);
    } else {
      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child("productImage")
          .child(productID)
          .putFile(pImage!);
      TaskSnapshot taskSnapshot = await uploadTask;
      String productImageUrl = await taskSnapshot.ref.getDownloadURL();
      addProduct(productID, productImageUrl);
    }
  }

  void addProduct(String productID, String imageUrl) async {
    try {
      await FirebaseFirestore.instance
          .collection("Products")
          .doc(productID)
          .set({
        "productID": productID,
        "Name": name.text,
        "Price": price.text,
        "Category": defaulVal,
        "Description": description.text,
        "image": imageUrl
      });
      Navigator.pop(context); // Bottom Sheet
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Product Added"))); // stf
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void updateProduct(String pID) async {
    try {
      await FirebaseFirestore.instance.collection("Products").doc(pID).update({
        "Name": name.text,
        "Price": price.text,
        "Description": description.text,
        "Categories": defaulVal
      });
      Navigator.pop(context); // Bottom Sheet
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Product Updated"))); // stf
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }


  File? pImage;
  Uint8List productImage = Uint8List(8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.98),
        child: Column(

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Products',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                ElevatedButton(  onPressed: () {
                  showModalBottomSheet(
                    elevation: 0,
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(
                        builder: (context, setState) {
                          // Values Update in Bottom Sheet
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      XFile? pickImage = await ImagePicker()
                                          .pickImage(source: ImageSource.gallery);
                                      if (kIsWeb) {
                                        if (pickImage != null) {
                                          var convertedFile =
                                          await pickImage.readAsBytes();
                                          setState(() {
                                            productImage = convertedFile;
                                          });
                                        }
                                      } else {
                                        if (pickImage != null) {
                                          File convertedFile = File(pickImage.path);
                                          setState(() {
                                            pImage = convertedFile;
                                          });
                                        }
                                      }
                                    },
                                    child: kIsWeb
                                        ? CircleAvatar(
                                      radius: 50,
                                      backgroundColor: Colors.grey,
                                      backgroundImage: productImage != null
                                          ? MemoryImage(productImage!)
                                          : null,
                                    )
                                        : CircleAvatar(
                                      radius: 50,
                                      backgroundColor: Colors.grey,
                                      backgroundImage: pImage != null
                                          ? FileImage(pImage!)
                                          : null,
                                    ),
                                  ),
                                  TextFormField(
                                    controller: name,
                                    validator: (val) {
                                      if (val == " " || val != null) {
                                        return "Fill the Field";
                                      }
                                    },
                              
                                    decoration: const InputDecoration(
                                        hintText: "Name**"),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                              
                                  TextFormField(
                                    controller: price,
                                    validator: (val) {
                                      if (val == " " || val != null) {
                                        return "Fill the Field";
                                      }
                                    },
                                    decoration: const InputDecoration(
                                        hintText: "Price**"),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    controller: description,
                                    validator: (val) {
                                      if (val == " " || val != null) {
                                        return "Fill the Field";
                                      }
                                    },
                                    decoration: const InputDecoration(
                                        hintText: "Description**"),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      DropdownButton(
                                        hint: const Text(
                                            'Category**'), // Not necessary for Option 1
                                        value: defaulVal,
                                        onChanged: (Val) {
                                          setState(() {
                                            defaulVal = Val;
                                            debugPrint(defaulVal);
                                          });
                                        },
                                        items: categories.map((value) {
                                          return DropdownMenuItem(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                      SizedBox(
width: 150,
                                        child: ElevatedButton(
                                            onPressed: () {
                                              addProductWithImage();
                                            },
                                            child: const Text("Add",style: TextStyle(color:Colors.white),),
                                            style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),

                                                                  ),
                                        ),
                                      )
                                    ],
                                  ),

                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                }, child: Text('Add Product'))
              ],
            ),
            SizedBox(height: 20,),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection("Products").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasData) {
                  var dataLength = snapshot.data!.docs.length;

                  return dataLength != 0
                      ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: dataLength,
                    itemBuilder: (context, index) {
                      String productName =
                      snapshot.data!.docs[index]["Name"];
                      String productPrice =
                      snapshot.data!.docs[index]["Price"];
                      String productCate =
                      snapshot.data!.docs[index]["Category"];
                      String productDes =
                      snapshot.data!.docs[index]["Description"];
                      String productImage = snapshot.data!.docs[index]["Image"];
                      String productID =
                      snapshot.data!.docs[index]["ProductID"];

                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: [
                            DataColumn(label: Text('ID')),
                            DataColumn(label: Text('Name')),
                            DataColumn(label: Text('Price')),
                            DataColumn(label: Text('Image')),
                            DataColumn(label: Text('Category')),
                            DataColumn(label: Text('Description')),
                          ],
                          rows: [
                            DataRow(cells: [
                              DataCell(Text(productID)),
                              DataCell(Text(productName)),
                              DataCell(Text('\$ ${productPrice}')),
                              DataCell(Container(child:Image.network(productImage))),
                              DataCell(Text(productCate)),
                              DataCell(Text(productDes)),
                            ]),
                          ],
                        ),
                      );
                    },
                  )
                      : Center(
                    child: Text("Nothing to show"),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
