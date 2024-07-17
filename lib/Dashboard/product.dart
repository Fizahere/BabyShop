import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class Product extends StatefulWidget {
  const Product({super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  final TextEditingController name = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController description = TextEditingController();
  List categories = ['Clothing', 'Shoes', 'Toys', 'Diapers', 'Baby Food'];
  dynamic defaulVal = 'Clothing';

  File? pImage;
  Uint8List productImage = Uint8List(8);

  void addProductWithImage() async {
    String productID = Uuid().v1();
    String productImageUrl = '';
    if (kIsWeb) {
      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child("Image")
          .child(productID)
          .putData(productImage);
      TaskSnapshot taskSnapshot = await uploadTask;
      productImageUrl = await taskSnapshot.ref.getDownloadURL();
    } else {
      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child("Image")
          .child(productID)
          .putFile(pImage!);
      TaskSnapshot taskSnapshot = await uploadTask;
      productImageUrl = await taskSnapshot.ref.getDownloadURL();
    }
    addProduct(productID, productImageUrl);
  }

  void addProduct(String productID, String imageUrl) async {
    try {
      await FirebaseFirestore.instance.collection("Products").doc(productID).set({
        "ProductID": productID,
        "Name": name.text,
        "Price": price.text,
        "Category": defaulVal,
        "Description": description.text,
        "Image": imageUrl
      });
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Product Added")));
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
        "Category": defaulVal
      });
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Product Updated")));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(9.98),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Products',
                      style:
                      TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          elevation: 0,
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                              builder: (context, setState) {
                                return Container(
                                  margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            XFile? pickImage =
                                            await ImagePicker().pickImage(
                                                source: ImageSource.gallery);
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
                                                File convertedFile =
                                                File(pickImage.path);
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
                                            backgroundImage:
                                            productImage.isNotEmpty
                                                ? MemoryImage(
                                                productImage)
                                                : null,
                                          )
                                              : CircleAvatar(
                                            radius: 50,
                                            backgroundColor: Colors.grey,
                                            backgroundImage: pImage != null
                                                ? FileImage(pImage!)
                                                : null,
                                            // child: Icon(Icons.add),
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
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            DropdownButton(
                                              hint: const Text('Category**'),
                                              value: defaulVal,
                                              onChanged: (val) {
                                                setState(() {
                                                  defaulVal = val;
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
                                                child: const Text(
                                                  "Add",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(Colors.blue),
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
                      },
                      child: Text('Add Product'))
                ],
              ),
              SizedBox(
                height: 20,
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Products")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData) {
                    var dataLength = snapshot.data!.docs.length;
        
                    List<DataRow> rows = [];
                    for (int index = 0; index < dataLength; index++) {
                      String productName = snapshot.data!.docs[index]["Name"];
                      String productPrice = snapshot.data!.docs[index]["Price"];
                      String productCate = snapshot.data!.docs[index]["Category"];
                      String productDes =
                      snapshot.data!.docs[index]["Description"];
                      String productImage =
                      snapshot.data!.docs[index]["Image"];
        
                      rows.add(
                        DataRow(cells: [
                          DataCell(Text('${index + 1}')),
                          DataCell(Text(productName)),
                          DataCell(Text('\$ $productPrice')),
                          DataCell(
                            Container(
                              width: 100,
                              height: 100,
                              child: Image.network(
                                productImage,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(Icons.error);
                                },
                                loadingBuilder: (context, child, progress) {
                                  return progress == null
                                      ? child
                                      : Center(child: CircularProgressIndicator());
                                },
                              ),
                            ),
                          ),
                          DataCell(Text(productCate)),
                          DataCell(Text(productDes)),
                        ]),
                      );
                    }
        
                    return dataLength != 0
                        ? SingleChildScrollView(
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
                        rows: rows,
                      ),
                    )
                        : Center(
                      child: Text("No Products"),
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
      ),
    );
  }
}
