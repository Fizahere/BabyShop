import 'package:flutter/material.dart';

class ButtonUtils {
  static ElevatedButton googleButton() {
    return ElevatedButton(
      onPressed: () {
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        side: MaterialStateProperty.all<BorderSide>(
          BorderSide(color: Colors.grey[300]!, width: 1.0),
        ),
      ),
      child: Center(
        child: Row(
          children: [
            Image.asset('images/google.png', height: 20, width: 20,),
            const SizedBox(width: 30,),
            const Text(
              'Sign in with Google',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

}
