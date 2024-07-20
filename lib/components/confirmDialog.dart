import 'package:flutter/material.dart';

showAlertDialog(BuildContext context ) {
  // set up the buttons
  bool ifDelete= false;
  Widget cancelButton = ElevatedButton(
    child: Text("Cancel"),
    onPressed:  () {
      ifDelete=false;
    },
  );
  Widget continueButton = ElevatedButton(
    child: Text("Delete",style: TextStyle(color: Colors.red)),
    onPressed:  () {
      ifDelete=true;
      // DeleteProduct();
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Delete",),
    content: Text("Are you sure?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
// return const isDelete={
//   isDelete;
// };

}