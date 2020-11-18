import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bookonline/Decorations/input_decoration.dart';
import 'package:bookonline/Common/dropdowntext.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bookonline/Decorations/loader.dart';

class BuyHome extends StatefulWidget {
  @override
  _BuyHomeState createState() => _BuyHomeState();
}

class _BuyHomeState extends State<BuyHome> {

  DropDownFiles dr = DropDownFiles();
  String board = "SSC", std = "1st";
  dynamic data;
  dynamic img;
  int ld = 0;

  Future getAllBooks() async {
    var url = 'https://birk-evaluation.000webhostapp.com/get_books.php';

    var response = await http.get(url);
    setState(() {
      data = jsonDecode(response.body);
    });
  }

  Future getBooks() async {
    var url = 'https://birk-evaluation.000webhostapp.com/search_list_book.php';
    var dt = {
      "board" : board,
      "std" : std,
    };

    var response = await http.post(url, body: dt);
    setState(() {
      data = jsonDecode(response.body);
    });
    ld = 0;
  }

  void initState(){
    super.initState();
    getAllBooks();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Search",
              style: TextStyle(
                  fontFamily: 'RobotoMono',
                  fontSize: 25.0,
                  letterSpacing: 2.0
              ),),
            centerTitle: true,
            actions: [
              IconButton(icon: Icon(Icons.power_settings_new, color: Colors.red,),
                  onPressed: () => Navigator.pushReplacementNamed(context, "/")),
            ],
          ),

        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),

          child: (data == null) ?
          SpinKitCircle(
            color: Colors.blue,
            size: 60.0,
          )  :

          Stack(
            children: [
              Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                  SizedBox(
                    width: 160.0,
                    height: 60.0,
                    child: DropdownButtonFormField(
                      value: board,
                      decoration: textInputDecoration,
                      items: dr.boards.map((st) {
                        return DropdownMenuItem(
                          value: st,
                          child: Text('$st'),
                        );
                      }).toList(),
                      onChanged: (v) async {
                        board = v;
                        setState(() => ld = 1);
                        getBooks();
                      },
                    ),
                  ),

                  SizedBox(
                    width: 150.0,
                    height: 60.0,
                    child: DropdownButtonFormField(
                    value: std,
                    decoration: textInputDecoration,
                    items: dr.standards.map((st) {
                      return DropdownMenuItem(
                        value: st,
                        child: Text('$st'),
                      );
                    }).toList(),
                      onChanged: (v) async {
                        std = v;
                        setState(() => ld = 1);
                        getBooks();
                      },
                  ),
                  ),
                ],
              ),

                SizedBox(height: 30),

                data == "0 results" ?
                Container(
                    child: Center(
                      child: Text("No Books on this Category",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2),),
                    )
                )  :

                Flexible (
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, "/pdp", arguments: data[index]);
                          },
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                      border: Border.all(color: Colors.redAccent, width: 2.0),
                                        borderRadius: BorderRadius.circular(7),
                                        ),

                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          height: 120,
                                          width: 110,
                                          child: Image.network(
                                            "http://birk-evaluation.000webhostapp.com/" + data[index]["pic1"],
                                            fit: BoxFit.fill,
                                          )
                                        ),

                                        Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(data[index]["standard"] + "   " + data[index]["subject"],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17.0
                                                ),),

                                              Text("(" + data[index]["boards"] + ")",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17.0
                                                ),),

                                              SizedBox(height: 10),

                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text("Rs: ",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 14
                                                      ),),

                                                    SizedBox(width: 5),

                                                    Text(data[index]["price"],
                                                      style: TextStyle(fontSize: 25,),),
                                                  ]
                                              ),

                                              SizedBox(height: 25),

                                              Column(
                                                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  Text("Seller from:",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold
                                                  ),),

                                                  SizedBox(width: 5),

                                                  Text(data[index]["state"]),
                                                ]
                                              ),
                                            ]
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: 10),

                                  Divider(
                                    thickness: 1.5,
                                    color: Colors.blueAccent,
                                  )
                                ]
                            ),
                          ),
                        );
                      }
                  ),
                ),
             ]
            ),
              Center(
                child: Loader(load: ld),
              ),
           ]
          ),
        )
      ),
    );
  }
}
