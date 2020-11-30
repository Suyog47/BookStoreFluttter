import 'package:bookonline/Decorations/loader.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WishList extends StatefulWidget {
  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {

  Map edata = {};
  dynamic data;

  Future getWishlist(String email) async {
    var url = 'https://birk-evaluation.000webhostapp.com/get_wishlist.php';
    var dt = {
      "email" : email
    };

    var response = await http.post(url, body: dt);
    (this.mounted) ? setState(() => data = jsonDecode(response.body)) : null;
  }


  @override
  Widget build(BuildContext context) {

    edata = ModalRoute.of(context).settings.arguments;
    getWishlist(edata["email"]);

    return Scaffold(
      appBar: AppBar(
        title: Text("Your WishList",
          style: TextStyle(fontFamily: 'BigShoulders', letterSpacing: 2, fontWeight: FontWeight.bold, fontSize: 26),),
        centerTitle: true,
      ),

      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),

          child: (data == null) ?
          Center(child: NLoader(load: 1)) :

          Stack(
          children: [
            data == "0 results" ?
            Container(
                child: Center(
                  child: Text("No Books on your WishList",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2),),
                )
            )  :

            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, "/pdp", arguments: data[index]);
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
            ]
          ),
      ),
    );
  }
}
