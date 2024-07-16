import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Users extends StatefulWidget {
  const Users({Key? key}) : super(key: key);

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(9.98),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Users',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            SizedBox(height: 20),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("userInfo").snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: [
                          DataColumn(label: Text('ID')),
                          DataColumn(label: Text('Name')),
                          DataColumn(label: Text('Phone')),
                          DataColumn(label: Text('Address')),
                          DataColumn(label: Text('Payment Method')),
                        ],
                        rows: snapshot.data!.docs.asMap().entries.map((entry) {
                          int index = entry.key;
                          var doc = entry.value;
                          String userName = doc["Name"];
                          String userContact = doc["Contact"];
                          String userAddress = doc["Address"];
                          String paymentMethod = doc["Payment"];

                          return DataRow(cells: [
                            DataCell(Text((index + 1).toString())),
                            DataCell(Text(userName)),
                            DataCell(Text(userContact)),
                            DataCell(Text(userAddress)),
                            DataCell(Text(paymentMethod)),
                          ]);
                        }).toList(),
                      ),
                    );
                  } else {
                    return Center(
                      child: Text("No Users"),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
