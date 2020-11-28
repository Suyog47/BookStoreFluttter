import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:bookonline/Decorations/loader.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class PDP extends StatefulWidget {
  @override
  _PDPState createState() => _PDPState();
}

class _PDPState extends State<PDP> {

  Map data = {};
  int _currentIndex = 0;
  dynamic dt;
  bool chk, flag = true, ld = false;

  Future getRecommendedBooks(String board, String std, String id) async {
    var url = 'https://birk-evaluation.000webhostapp.com/recomendation_books.php';
    var dte = {
      "board" : board,
      "id" : id
    };

    var response = await http.post(url, body: dte);
    (this.mounted) ? setState(() => dt = jsonDecode(response.body)) : null;
  }

  void addToWishList(String board, String std, String id, String email) async {
    setState(() => ld = true);
    var url = 'https://birk-evaluation.000webhostapp.com/add_to_wishlist.php';
    var dte = {
      "id" : id,
      "email" : email
    };

    var response = await http.post(url, body: dte);
    if(jsonDecode(response.body)){
      (this.mounted) ? setState(() => chk = !chk) : null;
      Fluttertoast.showToast(msg: "Added to Wishlist", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER, backgroundColor: Colors.green, textColor: Colors.white, fontSize: 17);
    }
    else{
      Fluttertoast.showToast(msg: "Sorry something went wrong...try again", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER, backgroundColor: Colors.yellow, textColor: Colors.grey, fontSize: 17);
    }
    setState(() => ld = false);
    getRecommendedBooks(board, std, id);
  }


  void removeFromWishList(String board, String std, String id, String email) async {
    setState(() => ld = true);
    var url = 'https://birk-evaluation.000webhostapp.com/remove_from_wishlist.php';
    var dte = {
      "id" : id,
      "email" : email
    };

    var response = await http.post(url, body: dte);
    if(jsonDecode(response.body)){
      (this.mounted) ? setState(() => chk = !chk) : null;
      Fluttertoast.showToast(msg: "Removed from Wishlist", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 17);
    }
    else{
      Fluttertoast.showToast(msg: "Sorry something went wrong...try again", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM, backgroundColor: Colors.yellow, textColor: Colors.grey, fontSize: 17);
    }
    setState(() => ld = false);
    getRecommendedBooks(board, std, id);
  }


  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    (dt == null) ? getRecommendedBooks(data["boards"], data["standard"], data["Id"]) : null;
    (flag) ? setState(() {chk = (data["status"] == "checked") ? true : false; flag = false;}) : null;

    return Scaffold(
        appBar: AppBar(
          title: Text("Product Page",
            style: TextStyle(
                fontFamily: 'RobotoMono',
                fontSize: 20.0,
                letterSpacing: 2.0
            ),),
        ),

        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Container(
              padding: EdgeInsets.fromLTRB(15, 30, 15, 0),

              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 250,
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: 250.0,
                          aspectRatio: 16/9,
                          enableInfiniteScroll: true,
                          autoPlay: true,
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                        ),
                        items: [data["pic1"], data["pic2"], data["pic3"], data["pic4"]].map((url) {
                          return Builder(
                            builder: (BuildContext context) {
                              return InkWell(
                                onTap: (){
                                  Navigator.pushNamed(context, "/imgzoom", arguments: {"img" : url});
                                },
                                child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                                    decoration: BoxDecoration(
                                        color: Colors.grey
                                    ),
                                    child: Image.network(
                                        "http://birk-evaluation.000webhostapp.com/" + url,
                                        fit: BoxFit.fill,
                                      loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress.expectedTotalBytes != null ?
                                            loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                                : null,
                                          ),
                                        );
                                      },
                                    ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 8.0,
                          height: 8.0,
                          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentIndex == 0 ? Colors.blueAccent : Colors.grey,
                          ),
                        ),

                        Container(
                          width: 8.0,
                          height: 8.0,
                          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentIndex == 1 ? Colors.blueAccent : Colors.grey,
                          ),
                        ),

                        Container(
                          width: 8.0,
                          height: 8.0,
                          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentIndex == 2 ? Colors.blueAccent : Colors.grey,
                          ),
                        ),

                        Container(
                          width: 8.0,
                          height: 8.0,
                          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentIndex == 3 ? Colors.blueAccent : Colors.grey,
                          ),
                        ),
                      ]
                    ),


                    SizedBox(height: 15.0),

                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           (chk == false) ? IconButton(icon: Icon(Icons.bookmark_border), color: Colors.black, iconSize: 35,
                              onPressed: () {
                                (!ld) ? addToWishList(data["boards"], data["standard"], data["Id"], data["email"]) : null;
                              })
                              :
                          IconButton(icon: Icon(Icons.bookmark), color: Colors.red, iconSize: 35,
                              onPressed: (){
                                (!ld) ? removeFromWishList(data["boards"], data["standard"], data["Id"], data["email"]) : null;
                              }),

                          WishlistLoader(ld: ld),
                        ],
                      ),
                    ),


                    SizedBox(height: 5.0),
                    Divider(thickness: 1.5,
                      color: Colors.grey,),
                    SizedBox(height: 15.0),


                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(data["standard"] + " ", style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),),

                          SizedBox(width: 10),

                          Text(data["subject"] + " ", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),

                          SizedBox(width: 10),

                          Text("("+data["boards"]+")", style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline)),

                        ]
                    ),

                    SizedBox(height: 20.0),

                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Price: ",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14
                            ),),

                          SizedBox(width: 5),

                          Text(data["price"],
                            style: TextStyle(fontSize: 30,
                                color: Colors.red,
                                decoration: TextDecoration.underline, fontWeight: FontWeight.bold)),
                        ]
                    ),

                    SizedBox(height: 10.0),
                    Divider(thickness: 1.5,
                      color: Colors.red),
                    SizedBox(height: 10.0),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text("Description: ",
                          style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                              decoration: TextDecoration.underline
                      ),),

                        SizedBox(height: 10),

                        Text(
                            data["description"],
                          style: TextStyle(fontSize: 15)),
                        ]
                    ),

                    SizedBox(height: 5.0),
                    Divider(thickness: 1.5,
                      color: Colors.red,),
                    SizedBox(height: 5.0),

                    Text("Sellers Info: ",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          decoration: TextDecoration.underline
                      ),),

                    SizedBox(height: 25.0),

                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Name: ",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 17
                            ),),

                          SizedBox(width: 5),

                          Text(data["fullname"], style: TextStyle(fontSize: 17),),
                        ]
                    ),

                    SizedBox(height: 25.0),

                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Email Id: ",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 17
                            ),),

                          SizedBox(width: 5),

                          Text(data["email"], style: TextStyle(fontSize: 17)),
                        ]
                    ),

                    SizedBox(height: 25.0),

                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Location: ",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 17
                            ),),

                          SizedBox(width: 5),

                          Text(data["state"], style: TextStyle(fontSize: 17),),
                        ]
                    ),

                    SizedBox(height: 25.0),

                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Phone No: ",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 17
                            ),),

                          SizedBox(width: 5),

                          Text(data["phoneno"], style: TextStyle(fontSize: 17)),
                        ]
                    ),

                    SizedBox(height: 15.0),
                    Divider(thickness: 1.5,
                      color: Colors.grey,),
                    SizedBox(height: 15.0),

                    Text("Recomendations: ",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          decoration: TextDecoration.underline
                      ),),

                    SizedBox(height: 20.0),


                    (dt == null) ?
                    SpinKitCircle(
                      color: Colors.blue,
                      size: 60.0,
                    )
                        :

                    (dt == "0") ?
                    Container(
                      child: Center(
                        child: Text("Don't have any recomended books",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2),),
                      ),
                    )
                        :

                    Flexible(
                      fit: FlexFit.loose,
                      child: Container(
                        height: 305,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: dt.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: (){
                                  Navigator.pushReplacementNamed(context, "/pdp", arguments: dt[index]);
                                },

                                child: Card(
                                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7.0),
                                  ),

                                  child: Container(
                                   padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),

                                    child: Column(
                                      children: [
                                        SizedBox(
                                            height: 120,
                                            width: 110,
                                            child: Image.network(
                                              "http://birk-evaluation.000webhostapp.com/" + dt[index]["pic1"],
                                              fit: BoxFit.fill,
                                            )
                                        ),

                                        SizedBox(height: 10),

                                        Text(dt[index]["standard"] + "   " + dt[index]["subject"],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17.0
                                          ),),

                                        Text("(" + dt[index]["boards"] + ")",
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

                                              Text(dt[index]["price"],
                                                style: TextStyle(fontSize: 25,),),
                                            ]
                                        ),

                                        SizedBox(height: 10),

                                        Text("Seller from:",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold
                                          ),),

                                        //SizedBox(width: 5),

                                        Text(dt[index]["state"]),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                        ),
                      ),
                    )
                  ]
              )
          ),
        )
    );
  }
}
