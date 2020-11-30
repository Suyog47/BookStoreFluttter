import 'package:flutter/material.dart';
import 'package:bookonline/Decorations/input_decoration.dart';
import 'package:bookonline/Common/dropdowntext.dart';
import 'package:bookonline/Common/book_data.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {

  DropDownFiles dr = DropDownFiles();
  BookData dt = BookData();
  Map data = {};

  String _boards;
  String _standard;
  String _subject;

  @override
  Widget build(BuildContext context) {

    data = ModalRoute.of(context).settings.arguments;
    dt.task = data["task"];
    dt.id = (data["data"] != null) ? data["data"]["Id"] : '0';
    _boards = (data["data"] != null) ? data["data"]["boards"] : "SSC";
    _standard = (data["data"] != null) ? data["data"]["standard"] : '1st';
    _subject = (data["data"] != null) ? data["data"]["subject"] : 'English';


    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Select Category",
              style: TextStyle(fontFamily: 'BigShoulders', letterSpacing: 2, fontWeight: FontWeight.bold, fontSize: 26),),
            centerTitle: true,
          ),
          body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [ Colors.yellow[200], Colors.white]
                )
            ),
            padding: EdgeInsets.all(30),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Select Boards :",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17
                  ),),

                SizedBox(height: 10),

                DropdownButtonFormField(
                  value: _boards,
                  decoration: textInputDecoration,
                  items: dr.boards.map((st) {
                    return DropdownMenuItem(
                      value: st,
                      child: Text('$st'),
                    );
                  }).toList(),
                  onChanged: (val){
                    _boards = val;
                  },
                ),

                SizedBox(height: 40),

                Text("Select Standards :",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17
                  ),),

                SizedBox(height: 10),

                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  value: _standard,
                  items: dr.standards.map((sug) {
                    return DropdownMenuItem(
                      value: sug,
                      child: Text(sug),
                    );
                  }).toList(),
                  onChanged: (val){
                    _standard = val;
                  },
                ),

                SizedBox(height: 40),

                Text("Select Subjects :",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17
                  ),),

                SizedBox(height: 10),

                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  value: _subject,
                  items: dr.subjects.map((sug) {
                    return DropdownMenuItem(
                      value: sug,
                      child: Text(sug),
                    );
                  }).toList(),
                  onChanged: (val){
                    _subject = val;
                  },
                ),

                SizedBox(height: 60),

                SizedBox(
                  height: 45,
                  width: 500,
                  child: RaisedButton.icon(
                    onPressed: (){
                      dt.email = data['email'];
                      dt.boards = _boards;
                      dt.standard = _standard;
                      dt.subject = _subject;
                      dt.desc = (data["data"] != null) ? data["data"]["description"] : null;
                      dt.prc = (data["data"] != null) ? data["data"]["price"] : null;
                     Navigator.pushNamed(context, '/img', arguments: {"data" : dt});
                    },
                    icon:Icon(Icons.keyboard_arrow_right),
                    label: Text("Next"),
                    color: Colors.yellow[500],),
                ),

              ],
            ),
          )
      ),
    );
  }
}
