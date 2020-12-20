import 'package:bookonline/Common/network_connectivity_status.dart';
import 'package:flutter/material.dart';
import 'package:bookonline/Decorations/input_decoration.dart';
import 'package:bookonline/Decorations/loader.dart';
import 'package:bookonline/Common/DB_functions.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdatePass extends StatefulWidget {
  @override
  _UpdatePassState createState() => _UpdatePassState();
}

class _UpdatePassState extends State<UpdatePass> {

  final _formkey = GlobalKey<FormState>();
  String _pass, _cpass, msg = "";
  int ld = 0;
  Map data = {};
  DBFunctions db = DBFunctions();
  NetworkCheck net = new NetworkCheck();

  void updateData() async {
    var url = "https://birk-evaluation.000webhostapp.com/update_pass.php";
    var dt = {
      "email" : data["email"],
      "pass" : _cpass
    };

    await db.updatePass(context, url, dt);
    setState(() => ld = 0);
  }

  @override
  Widget build(BuildContext context) {

    data = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("Update Password",
            style: TextStyle(fontFamily: 'BigShoulders', letterSpacing: 2, fontWeight: FontWeight.bold, fontSize: 26),),
          centerTitle: true,
        ),

      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 100),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Colors.blue, Colors.pinkAccent]
                  )
              ),
            child: Form(
            key: _formkey,
             child: Column(
             children: [
               Stack(
               children: <Widget>[
                 SizedBox(
                   height: 70.0,
                    child: new TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'Password:'),
                      validator: (val) => val.length < 6 || val.length > 20 ? 'Password should be between 6 to 20 chars.' : null,
                      onChanged: (val) => _pass = val,
                      obscureText: true,
                    ),
                 ),
               ],
               ),

               SizedBox(height: 25.0),

               Stack(
                 children: <Widget>[
                   SizedBox(
                     height: 70.0,
                     child: new TextFormField(
                       decoration: textInputDecoration.copyWith(hintText: 'Confirm Password:'),
                       validator: (val) => val.length < 6 || val.length > 20 ? 'Password should be between 6 to 20 chars.' : null,
                       onChanged: (val) => _cpass = val,
                       obscureText: true,
                     ),
                   ),
                 ],
               ),

               Text(msg, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),

               SizedBox(height: 35.0),

               SizedBox(
                 height: 45,
                 width: 250,
                 child: RaisedButton(
                   color: Colors.purpleAccent,
                   child: Text("Update", style: TextStyle(color: Colors.white, fontSize: 18)),
                   onPressed: () async {
                     if(_formkey.currentState.validate() && _pass == _cpass){
                       int stat = await net.checkNetwork();
                       if(stat == 1) {
                         setState(() => ld = 1);
                         updateData();
                       }
                       else{
                         Fluttertoast.showToast(msg: "Please connect to Internet first", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.TOP, backgroundColor: Colors.orange, textColor: Colors.black, fontSize: 17);
                       }
                     }
                     else{
                       setState(() => msg = "Confirm Password don't match");
                     }
                     },
                 ),
               ),
             ],
             ),
          )
        ),
          Center(
            child: Loader(load: ld),
          ),
       ]
      )
    );
  }
}
