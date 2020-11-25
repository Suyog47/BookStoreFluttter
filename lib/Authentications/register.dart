import 'package:flutter/material.dart';
import 'package:bookonline/Decorations/input_decoration.dart';
import 'package:flutter/services.dart';
import 'package:bookonline/Decorations/loader.dart';
import 'dart:io';
import 'package:bookonline/Common/dropdowntext.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bookonline/Common/DB_functions.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

   final List<String> state = ["Maharashtra", "Karnataka", "Gujrat", "Punjab", "Uttar-Pradesh", "Madhya-Pradesh", "Kerala", "Tamil-Nadu", "Delhi"];
   final _formkey = GlobalKey<FormState>();
   String _fullnm, _email, _pass, _num, _loc;
   String pin;
   int ld = 0;
   bool load = false;
   bool _obscureText = true;
   var txt = TextEditingController();
   DBFunctions db = new DBFunctions();

   void _toggle() {
     setState(() {
       _obscureText = !_obscureText;
     });
   }

   Future insertData() async {
     var url = 'https://birk-evaluation.000webhostapp.com/register.php';
     var data = {
       "name" : _fullnm,
       "email" : _email,
       "pass" : _pass,
       "pno": _num,
       "st" : _loc
     };

     await db.insertData(context, url, data);
     setState(() => ld = 0);
   }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          print(
              'Backbutton pressed (device or appbar button), do whatever you want.');
          exit(0);
          return Future.value(false);
        },
          child: Scaffold(
           resizeToAvoidBottomPadding: false,
           body: SafeArea(
            child: Stack(
             children : [
              Container(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [ Colors.yellow, Colors.orange]
                    )
                ),

                child: Column(
                  children: [
                    Text("Register",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 35.0,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'IndieFlower'
                      ),),


                    Flexible(
                      child: Form(
                        key: _formkey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextFormField(
                              decoration: textInputDecoration.copyWith(hintText: 'Full Name:'),
                              onChanged: (val) => _fullnm = val.trim(),
                              validator: (val) => val.isEmpty ? "Enter First Name" : null,
                            ),


                            TextFormField(
                              decoration: textInputDecoration.copyWith(hintText: 'Email Id:'),
                              onChanged: (val) => _email = val.trim(),
                              validator: (val) {
                                if(val.isNotEmpty && RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val)){
                                  return null;
                                }
                                  return "Enter valid email";
                                }
                                ),


                                Stack(
                                children: <Widget>[
                                SizedBox(
                                height: 70.0,
                                child: new TextFormField(
                                decoration: textInputDecoration.copyWith(hintText: 'Password:'),
                                validator: (val) => val.length < 6 || val.length > 20 ? 'Password should be between 6 to 20 chars.' : null,
                                onChanged: (val) => _pass = val,
                                obscureText: _obscureText,
                                ),
                                ),
                                Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                color: Colors.black,
                                      onPressed: _toggle,
                                      icon: Icon(_obscureText ? Icons.lock_open : Icons.lock)),
                                )
                              ],
                            ),


                            TextFormField(
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              keyboardType: TextInputType.number,
                              decoration: textInputDecoration.copyWith(hintText: 'Phone Number:'),
                              onChanged: (val) => _num = val.trim(),
                                validator: (val) {
                                  if(val.length == 10 && int.parse(val[0]) >= 7 ){
                                    return null;
                                  }
                                  return "Enter valid phone number";
                                }
                            ),


                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  height: 50.0,
                                  width: 170,
                                  child: TextFormField(
                                    decoration: textInputDecoration.copyWith(hintText: 'Pincode:'),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                    onChanged: (val) {
                                      setState(() => pin = val);
                                    },
                                  ),
                                ),


                                SizedBox(
                                  height: 45,
                                  width: 100,
                                  child: RaisedButton(
                                      onPressed: () async {
                                        if (pin != null && pin != "") {
                                          setState(() => load = true);
                                          GetLocation loc = GetLocation();
                                          var data = await loc.getData(pin);
                                          if(data == null){
                                            Fluttertoast.showToast(msg: "Please enter valid pincode", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 17);
                                          }
                                          else {
                                            setState(() => _loc = data);
                                            txt.text = _loc;
                                          }
                                        setState(() => load = false);
                                        }
                                        else{
                                          Fluttertoast.showToast(msg: "Please enter pincode first", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 17);
                                        }
                                      },
                                      child: Text("Search", style: TextStyle(color: Colors.white)),
                                      color: Colors.orange[500]),
                                ),

                                OtpLoader(ld: load),
                              ],
                            ),


                            SizedBox(
                              height: 50.0,
                              child: TextFormField(
                                controller: txt,
                                enabled: false,
                                decoration: textInputDecoration.copyWith(hintText: 'Location:'),
                              ),
                            ),


                            SizedBox(
                              height: 45,
                              width: 500,
                              child: RaisedButton(
                                color: Colors.green,
                                child: Text("Submit", style: TextStyle(color: Colors.white, fontSize: 18)),
                                onPressed: () async {
                                  if(_formkey.currentState.validate() && _loc != null){
                                    setState(() => ld = 1);
                                   insertData();
                                  }
                                  if(_loc == null){
                                    Fluttertoast.showToast(msg: "Please insert pincode and click search", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 17);
                                  }
                                },
                              ),
                            ),


                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Already registered?  Then  ", style: TextStyle(fontSize: 16, color: Colors.white)),
                                InkWell(
                                    onTap: (){
                                      Navigator.pushReplacementNamed(context, "/");
                                    },
                                    child: Text("Sign In", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19, color: Colors.white),)
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Loader(load: ld),
              ),
            ]
           ),
           )
          )
    );
  }
}
