
import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
       fillColor: Colors.white,
       filled: true,
       enabledBorder: OutlineInputBorder(
       borderSide: BorderSide(color: Colors.blueGrey, width: 2.0)
       ),
      focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.redAccent, width: 2.0)
    ),
);

const otpTextDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.black12,
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.redAccent, width: 2.0)
  ),
);