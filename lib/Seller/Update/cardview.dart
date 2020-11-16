import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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

  Future getBooks(String email) async {
    var url = 'https://birk-evaluation.000webhostapp.com/get_selected_books.php';
    var dt = {
      "email" : email,
    };
    var response = await http.post(url, body: dt);
    if (this.mounted) {
      setState(() {
        data = jsonDecode(response.body);
      });
    }
  }

  Future deleteBook(String id) async {
    var url = 'https://birk-evaluation.000webhostapp.com/delete_book.php';
    var dt = {
      "id" : id,
    };
    await db.deleteBook(context, url, dt);
    getBooks(emaildt["email"]);
  }

  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    emaildt = ModalRoute.of(context).settings.arguments;
    getBooks(emaildt["email"]);

      return Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            title: Text("Your Book List",
              style: TextStyle(
                  fontFamily: 'RobotoMono',
                  fontSize: 20.0,
                  letterSpacing: 2.0
              ),),
            centerTitle: true,
          ),

          body: (data == null) ?
          SpinKitCircle(
            color: Colors.red,
            size: 60.0,
          )

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
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.blueAccent, width: 2.0),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),

                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                              Text(data[index]["standard"] + "   " + data[index]["subject"] + "  (" + data[index]["boards"] + ")",
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

                                              SizedBox(height: 25),

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    height: 35,
                                                    width: 80,
                                                    child: RaisedButton(
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
                                                                color: Colors.white)),
                                                        color: Colors.red),
                                                  ),
                                                ],
                                              ),
                                            ]
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: 10),

                                  Divider(
                                    thickness: 1.5,
                                    color: Colors.red,
                                  )
                                ]
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
