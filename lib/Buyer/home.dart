import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bookonline/Decorations/input_decoration.dart';
import 'package:bookonline/Common/dropdowntext.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bookonline/Decorations/loader.dart';
import 'package:bookonline/Cache_Calls/log_status.dart';

class BuyHome extends StatefulWidget {
  @override
  _BuyHomeState createState() => _BuyHomeState();
}

class _BuyHomeState extends State<BuyHome> {

  Map edata = {};
  String email;
  DropDownFiles dr = DropDownFiles();
  String board = "All_Boards", std = "All_Standards";
  dynamic data;
  dynamic img;
  int ld = 0;
  GetSetLogStatus cache = GetSetLogStatus();


  Future getBooks() async {
    var url = 'https://birk-evaluation.000webhostapp.com/search_list_book.php';
    var dt = {
      "board": (board == "All_Boards") ? '%' : board,
      "std": (std == "All_Standards") ? '%' : std,
      "email" : email
    };

    var response = await http.post(url, body: dt);
    if (this.mounted) {
      setState(() {
        data = jsonDecode(response.body);
      });
    }
      ld = 0;
  }


  @override
  Widget build(BuildContext context) {
    edata = ModalRoute.of(context).settings.arguments;
    email = edata["email"];
    getBooks();

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Search",
              style: TextStyle(fontFamily: 'BigShoulders', letterSpacing: 2, fontWeight: FontWeight.bold, fontSize: 26),),
            centerTitle: true,
            actions: [
              IconButton(icon: Icon(Icons.bookmark, color: Colors.black),
                  onPressed: () => Navigator.pushNamed(context, "/wishlist", arguments: {"email" : email})),

              IconButton(icon: Icon(Icons.power_settings_new, color: Colors.red,),
                  onPressed: () async {
                    cache.deleteLoginStatus();
                    Navigator.pushReplacementNamed(context, "/");
                  }),
            ],
          ),

        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),

          child: (data == null) ?
          Center(child: NLoader(load: 1))
              :

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
                      items: dr.aboards.map((st) {
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
                    items: dr.astandards.map((st) {
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

                SizedBox(height: 20),

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
                            Navigator.pushNamed(context, "/pdp", arguments: {"data" : data[index], "eml" : email});
                          },
                          child: Card(
                            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.0),
                            ),

                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
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
