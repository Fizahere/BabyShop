import 'package:flutter/material.dart';

import '../components/table.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.98),
        child: Column(
          children: [
            Text('Users',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
            SizedBox(height: 20,),
            CustomDataTable(),
          ],
        ),
      ),
    );
  }
}
