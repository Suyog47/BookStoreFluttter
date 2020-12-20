import 'package:bookonline/Common/network_connectivity_status.dart';
import 'package:flutter/material.dart';
import 'package:bookonline/Decorations/input_decoration.dart';
import 'package:bookonline/Decorations/loader.dart';
import 'dart:io';
import 'package:bookonline/Common/DB_functions.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Sign_In extends StatefulWidget {
  @override
  _Sign_InState createState() => _Sign_InState();
}

class _Sign_InState extends State<Sign_In> {

  final _formkey = GlobalKey<FormState>();
  String _email;
  String _pass;
  bool _obscureText = true;
  int ld = 0;
  DBFunctions db = new DBFunctions();
  NetworkCheck net = new NetworkCheck();

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void getData() async {
   var url = "https://birk-evaluation.000webhostapp.com/login.php";
   var data = {
     "email" : _email,
     "pass" : _pass
   };

  await db.getSignInData(context, url, data, _email);
   setState(() => ld = 0);
}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print('Backbutton pressed (device or appbar button), do whatever you want.');
        exit(0);
        return Future.value(false);
      },
      child: Scaffold(
          resizeToAvoidBottomPadding: false,
       body: Stack(
         children: [
           Container(
           decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(20.0),
               gradient: LinearGradient(
                   begin: Alignment.topRight,
                   end: Alignment.bottomLeft,
                   colors: [ Colors.lightGreen, Colors.blue]
               )
           ),
           padding: EdgeInsets.fromLTRB(20.0, 60.0, 20.0, 0.0),
             child: Center(
              child: Column(
               crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 Text("Login",
                       style: TextStyle(
                         color: Colors.white,
                         fontSize: 55.0,
                         letterSpacing: 3,
                         fontWeight: FontWeight.bold,
                         fontFamily: 'NerkoOne'
                       ),),

                 SizedBox(height: 40.0),

                 Form(
                   key: _formkey,
                   child: Column(
                     children: [
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

                       SizedBox(height: 15.0),

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

                       SizedBox(height: 30.0),

                       SizedBox(
                         height: 45,
                         width: 500,
                         child: RaisedButton(
                           color: Colors.redAccent,
                           child: Text("Log In", style: TextStyle(color: Colors.white, fontSize: 18)),
                           onPressed: () async {
                             if (_formkey.currentState.validate()) {
                               int stat = await net.checkNetwork();
                               if (stat == 1) {
                                 setState(() => ld = 1);
                                 getData();
                               }
                               else{
                                 Fluttertoast.showToast(msg: "Please connect to Internet first", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.TOP, backgroundColor: Colors.orange, textColor: Colors.black, fontSize: 17);
                               }
                             }
                           }
                         ),
                       ),

                       SizedBox(height: 10),
                       InkWell(
                           onTap: (){
                             Navigator.pushNamed(context, "/otp");
                           },
                           child: Text("Forget Password?", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),)
                       ),

                       SizedBox(height: 90),

                      // Text("Or", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19)),

                       SizedBox(height: 60),

                       Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                           Text("Are you new?  Then  ", style: TextStyle(fontSize: 16, color: Colors.white)),
                           InkWell(
                             onTap: (){
                               Navigator.pushReplacementNamed(context, "/register");
                             },
                               child: Text("Register", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19, color: Colors.white),)
                           )
                         ],
                       )
                     ],
                   ),
                 ),
               ],
             ),
           ),
         ),
           Center(
             child: Loader(load: ld),
           ),
      ]
       ),
      ),
    );
  }
}
