import 'package:bookonline/Common/network_connectivity_status.dart';
import 'package:flutter/material.dart';
import 'package:bookonline/Decorations/input_decoration.dart';
import 'package:bookonline/Common/book_data.dart';
import 'package:flutter/services.dart';
import 'package:bookonline/Decorations/loader.dart';
import 'package:bookonline/Common/DB_functions.dart';
import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';

class PriceDesc extends StatefulWidget {
  @override
  _PriceDescState createState() => _PriceDescState();
}

class _PriceDescState extends State<PriceDesc> {

  Map data = {};
  final _formkey = GlobalKey<FormState>();
  BookData dt = BookData();
  DBFunctions db = DBFunctions();
  String id, desc, prc;
  int ld = 0;
  NetworkCheck net = new NetworkCheck();


  void insert_OR_update(var task) async {
    var img1 = base64Encode(dt.pic1.readAsBytesSync());
    var img2 = base64Encode(dt.pic2.readAsBytesSync());
    var img3 = base64Encode(dt.pic3.readAsBytesSync());
    var img4 = base64Encode(dt.pic4.readAsBytesSync());
    var data = {
      "id" : dt.id,
      "email": dt.email,
      "board": dt.boards,
      "std": dt.standard,
      "subj": dt.subject,
      "pic1": img1,
      "pic2": img2,
      "pic3": img3,
      "pic4": img4,
      "desc": desc,
      "prc": prc,
    };
    print(data);

    if(task == "insert") {
      var url = 'https://birk-evaluation.000webhostapp.com/book_upload.php';
      await db.insertBookData(context, url, data);
    }
    else {
      var url = 'https://birk-evaluation.000webhostapp.com/update_book.php';
      await db.updateData(context, url, data);
    }
      setState(() => ld = 0);
    }


  @override
  Widget build(BuildContext context) {

    data = ModalRoute.of(context).settings.arguments;
    dt = data["data"];
    id = dt.id;
    desc = dt.desc;
    prc = dt.prc;

    return Scaffold(
      appBar: AppBar(
        title: Text("Give Final Details",
          style: TextStyle(fontFamily: 'BigShoulders', letterSpacing: 2, fontWeight: FontWeight.bold, fontSize: 26),),
        centerTitle: true,
      ),

      body: Stack(
        children: [
          Form(
          key: _formkey,
           child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [ Colors.yellow[200], Colors.white]
                )
            ),
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 60.0),

            child: SingleChildScrollView(
              child: Column(
                  children: [
                    TextFormField(
                      minLines: 10,
                      maxLines: 20,
                      initialValue: desc,
                      decoration: textInputDecoration.copyWith(hintText: 'Description :'),
                      onChanged: (val) {
                        desc = val;
                      },
                      validator: (val) => val.isEmpty ? "Enter Description" : null,
                    ),

                    SizedBox(height: 30.0),

                    SizedBox(
                      height: 50.0,
                      width: 190.0,
                      child: TextFormField(
                        initialValue: prc,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        keyboardType: TextInputType.number,
                        decoration: textInputDecoration.copyWith(hintText: 'Price :'),
                        onChanged: (val) {
                          prc = val;
                        },
                        validator: (val) => val.isEmpty ? "Enter Price" : null,
                      ),
                    ),

                    SizedBox(height: 50.0),

                    SizedBox(
                      height: 45,
                      width: 500,
                      child: RaisedButton.icon(
                          onPressed: () async {
                            if(_formkey.currentState.validate()) {
                              int stat = await net.checkNetwork();
                              if (stat == 1) {
                                setState(() => ld = 1);
                                var task = dt.task;
                                insert_OR_update(task);
                              }
                              else{
                                Fluttertoast.showToast(msg: "Please connect to Internet first", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.TOP, backgroundColor: Colors.orange, textColor: Colors.black, fontSize: 17);
                              }
                            }
                          },
                          icon:Icon(Icons.assignment_turned_in),
                          label: Text("Submit"),
                          color: Colors.orange[300]),
                    ),
                  ]
              ),
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
