import 'package:flutter/material.dart';
import 'package:bookonline/Decorations/input_decoration.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bookonline/Common/dropdowntext.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bookonline/Decorations/loader.dart';
import 'package:bookonline/Common/DB_functions.dart';

class Updation extends StatefulWidget {
  @override
  _UpdationState createState() => _UpdationState();
}

class _UpdationState extends State<Updation> {

  Map data = {};
  dynamic res;

  final List<String> state = ["Maharashtra", "Karnataka", "Gujarat", "Punjab"];
  final _formkey = GlobalKey<FormState>();
  String _fullnm, _num, _pass, _loc, pin;
  bool _obscureText = true, load = false, check = true;
  int ld = 0;
  var txt = TextEditingController();
  DBFunctions db = new DBFunctions();

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future getData(String email) async {
    var url = "https://birk-evaluation.000webhostapp.com/get_profile.php";
    var data = {
      "email" : email,
    };
    var response = await http.post(url, body: data);
    res = jsonDecode(response.body);
      setState(() => res = res);

      _fullnm = res["fullname"];
      _num = res["phoneno"];
      _pass = res["password"];
      _loc = res["state"];
      txt.text = _loc;
      check = false;
  }

  Future updateData(String email) async {
    var url = "https://birk-evaluation.000webhostapp.com/update_profile.php";
    var dt = {
      "email" : email,
      "name" : _fullnm,
      "phone" : _num,
      "state" : _loc,
      "pass" : _pass
    };
    await db.updateProfile(context, url, dt);
    setState(() => ld = 0);
  }

  @override
  Widget build(BuildContext context) {

    data = ModalRoute.of(context).settings.arguments;
    (check) ? getData(data["email"]) : null;

    return Scaffold(
    resizeToAvoidBottomPadding: false,
      appBar: AppBar(
          title: Text("Update Profile",
            style: TextStyle(
                fontFamily: 'RobotoMono',
                fontSize: 20.0,
                letterSpacing: 2.0
            ),),
        centerTitle: true,
      ),

     body: (res == null) ?

    Center(
      child: Loader(load: 1),
    ) :

    Stack(
      children: [
        Form(
          key: _formkey,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [ Colors.green[200], Colors.white]
              )
          ),
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            
            child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                    Text("Full Name:"),
                    SizedBox(
                      height: 50.0,
                      child: TextFormField(
                        initialValue: _fullnm,
                        decoration: textInputDecoration,
                        onChanged: (val) => _fullnm = val,
                        validator: (val) => val.isEmpty ? "Enter First Name" : null,
                      ),
                    ),


              Text("Email Id:"),
              SizedBox(
                height: 50.0,
                child: TextFormField(
                  initialValue: data["email"],
                  enabled: false,
                  decoration: textInputDecoration,
                  validator: (val) => val.isEmpty ? "Enter Email" : null,
                ),
              ),


              Text("Phone No:"),
              SizedBox(
                height: 50.0,
                child: TextFormField(
                  initialValue: _num,
                  decoration: textInputDecoration,
                  onChanged: (val) => _num = val,
                  validator: (val) => val.length != 10 ? "Invalid Number" : null,
                ),
              ),


              Text("Password:"),
              Container(
                child: Stack(
                  children: <Widget>[
                    SizedBox(
                      height: 60.0,
                      child: new TextFormField(
                        initialValue: _pass,
                        decoration: textInputDecoration,
                        validator: (val) => val.length < 6 || val.length > 20 ? 'Password should be between 6 to 25 chars.' : null,
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
              ),


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 40.0,
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
                    height: 40,
                    width: 100,
                    child: RaisedButton(
                        onPressed: () async {
                          if (pin != null && pin != "") {
                            setState(() => load = true);
                            GetLocation db = GetLocation();
                            var data = await db.getData(pin);
                            txt.text = data;
                            setState(() {
                              _loc = data;
                              load = false;
                              txt.text = data;
                            });
                          }
                          else{
                            Fluttertoast.showToast(msg: "Please Enter Pincode", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 17);
                          }
                        },
                        child: Text("Search", style: TextStyle(color: Colors.white)),
                        color: Colors.orange[500]),
                  ),

                  OtpLoader(ld: load),
                ],
              ),

              Text("Location:"),
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
                  color: Colors.green[300],
                  child: Text("Update"),
                  onPressed: () {
                    if(_formkey.currentState.validate()) {
                      setState(() => ld = 1);
                      updateData(data["email"]);
                    }
                  },
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
      );
  }
}

