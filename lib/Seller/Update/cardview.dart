import 'package:bookonline/Common/network_connectivity_status.dart';
import 'package:bookonline/Decorations/loader.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sweetalert/sweetalert.dart';
import 'package:bookonline/Common/DB_functions.dart';

class BookCards extends StatefulWidget {
  @override
  _BookCardsState createState() => _BookCardsState();
}

class _BookCardsState extends State<BookCards> {

  dynamic data, res;
  Map emaildt = {};
  DBFunctions db = new DBFunctions();
  NetworkCheck net = new NetworkCheck();

  Future getBooks(String email) async {
    int stat = await net.checkNetwork();
    if (stat == 1) {
      var url = 'https://birk-evaluation.000webhostapp.com/get_selected_books.php';
      var dt = {
        "email": email,
      };
      var response = await http.post(url, body: dt);
      if (this.mounted) {
        setState(() {
          data = jsonDecode(response.body);
        });
      }
    }
    else{
      Fluttertoast.showToast(msg: "Please connect to Internet first", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.TOP, backgroundColor: Colors.orange, textColor: Colors.black, fontSize: 17);
    }
  }

  Future deleteBook(String id) async {
    int stat = await net.checkNetwork();
    if (stat == 1) {
      var url = 'https://birk-evaluation.000webhostapp.com/delete_book.php';
      var dt = {
        "id": id,
      };
      await db.deleteBook(context, url, dt);
      getBooks(emaildt["email"]);
    }
    else{
      Fluttertoast.showToast(msg: "Please connect to Internet first", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.TOP, backgroundColor: Colors.orange, textColor: Colors.black, fontSize: 17);
    }
  }

  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    emaildt = ModalRoute.of(context).settings.arguments;
    (data == null) ? getBooks(emaildt["email"]) : null;

      return Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            title: Text("Your Book List",
              style: TextStyle(fontFamily: 'BigShoulders', letterSpacing: 2, fontWeight: FontWeight.bold, fontSize: 26),),
            centerTitle: true,
          ),

          body: (data == null) ?
          Center(child: NLoader(load: 1))

              : data == "0 results" ?
          Container(
            child: Center(
              child: Text("You have not Uploaded any Book",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2),),
            ),
           )

           : Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
            child: Column(
              children: [
                Flexible(
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, "/category", arguments: {"data" : data[index], "email" : emaildt["email"], "task" : "update"});
                          },
                          child: Card(
                            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9.0),
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

                                  //SizedBox(width: 20),

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

                                        Text(data[index]["price"],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25.0
                                          ),),

                                        SizedBox(height: 20),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              height: 35,
                                              width: 100,
                                              child: FlatButton(
                                                  onPressed: () {
                                                    SweetAlert.show(context, title: "Confirmation",
                                                        subtitle: "Really want to delete this book",
                                                        style: SweetAlertStyle.confirm,
                                                        showCancelButton: true,
                                                        onPress: (bool isConfirm){
                                                          if (isConfirm) {
                                                            deleteBook(data[index]["Id"]+"");
                                                          }
                                                          return true;
                                                        });
                                                  },
                                                  child: Text("Delete",
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 17)),
                                                  color: Colors.white),
                                            ),
                                          ],
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
              ],
            ),
          )
      );
    }
  }
