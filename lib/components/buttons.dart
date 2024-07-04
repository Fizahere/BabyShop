import 'dart:js';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ButtonUtils {
  static ElevatedButton googleButton() {
    return ElevatedButton(
      onPressed: () {
      },
      child: Center(
        child: Row(
          children: [
            Image.asset('images/google.png', height: 20, width: 20,),
            SizedBox(width: 30,),
            Text(
              'Sign in with Google',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        side: MaterialStateProperty.all<BorderSide>(
          BorderSide(color: Colors.grey[300]!, width: 1.0),
        ),
      ),
    );
  }

}
