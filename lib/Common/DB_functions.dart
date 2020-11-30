import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sweetalert/sweetalert.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bookonline/Cache_Calls/log_status.dart';

class DBFunctions {
  GetSetLogStatus cache = GetSetLogStatus();

  Future getSignInData(BuildContext context, var url, var data, var email) async {
    var response = await http.post(url, body: data);
    var res = jsonDecode(response.body);
    if(res){
      await cache.setLoginStatus(email);
      Navigator.pushReplacementNamed(context, "/select", arguments: {"email" : email});

    }
    else{
      SweetAlert.show(context, title: "Failed",
          subtitle: "Wrong Email or Password!!",
          style: SweetAlertStyle.confirm);
    }
  }


  Future updateProfile(BuildContext context, var url, var data) async {
    var response = await http.post(url, body: data);
    var res = jsonDecode(response.body);
    if(res){
      SweetAlert.show(context, title: "Success",
          subtitle: "Data Updated successfully",
          style: SweetAlertStyle.success);
    }
    else{
      SweetAlert.show(context, title: "Oops",
          subtitle: "Something went Wrong... Try again!!",
          style: SweetAlertStyle.error);
    }
  }

  Future updatePass(BuildContext context, var url, var data) async {
    var response = await http.post(url, body: data);
    var res = jsonDecode(response.body);

    if (res) {
      SweetAlert.show(context, title: "Success",
          subtitle: "Password updated successfully",
          style: SweetAlertStyle.success,
          onPress: (bool isConfirm) {
            if (isConfirm) {
              Navigator.pushReplacementNamed(context, "/");
            }
            return false;
          });
    }
    else {
      Fluttertoast.showToast(msg: "Something went wrong...Please try again", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM, backgroundColor: Colors.red, textColor: Colors.white);
    }
  }

  Future insertData(BuildContext context, var url, var data) async {
    try {
      var response = await http.post(url, body: data);
      var res = jsonDecode(response.body);

      if(res == "email exists") {
       print("This Email already exists");
     }
      else if (res) {
        SweetAlert.show(context, title: "Success",
            subtitle: "Data Registered successfully",
            style: SweetAlertStyle.success,
            onPress: (bool isConfirm){
            if (isConfirm) {
              Navigator.of(context).popUntil(ModalRoute.withName('/category'));
          }
          return true;
        });
      }
      else {
        SweetAlert.show(context, title: "Oops",
            subtitle: "Something went Wrong... Try again!!",
            style: SweetAlertStyle.error);
      }
    }
    catch (e) {
      print(e);
      SweetAlert.show(context, title: "Oops",
          subtitle: "" + e.toString(),
          style: SweetAlertStyle.error);
    }
  }


  Future updateData(BuildContext context, var url, var data) async {
    try {
      var response = await http.post(url, body: data);
      var res = jsonDecode(response.body);
      if (res) {
        SweetAlert.show(context, title: "Success",
            subtitle: "Data Updated successfully",
            style: SweetAlertStyle.success,
            onPress: (bool isConfirm){
              if (isConfirm) {
                Navigator.of(context).popUntil(ModalRoute.withName('/category'));
              }
              return true;
            });
      }
      else {
        SweetAlert.show(context, title: "Oops",
            subtitle: "Something went Wrong... Try again!!",
            style: SweetAlertStyle.error);
      }
    }
    catch (e) {
      print(e);
      SweetAlert.show(context, title: "Oops",
          subtitle: "" + e.toString(),
          style: SweetAlertStyle.error);
    }
  }


  Future deleteBook(BuildContext context, var url, var data) async {
    var response = await http.post(url, body: data);
    var res = jsonDecode(response.body);

    if(res) {
      SweetAlert.show(context, title: "Book deleted", style: SweetAlertStyle.success);
    }
    else{
      SweetAlert.show(context, title: "Something went wrong", style: SweetAlertStyle.error);
    }
  }
}