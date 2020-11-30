import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bookonline/Cache_Calls/log_status.dart';

class Selection extends StatelessWidget {

  Map data = {};
  GetSetLogStatus cache = GetSetLogStatus();

  @override
  Widget build(BuildContext context) {

    data = ModalRoute.of(context).settings.arguments;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Book Store", style: TextStyle(fontFamily: 'BigShoulders', letterSpacing: 2, fontWeight: FontWeight.bold, fontSize: 26),),
          actions: [
            IconButton(icon: Icon(Icons.account_circle, color: Colors.white),
                onPressed: () => Navigator.pushNamed(context, "/updation", arguments: {"email" : data["email"]})),

            IconButton(icon: Icon(Icons.power_settings_new, color: Colors.red,),
                onPressed: () async {
              cache.deleteLoginStatus();
              Navigator.pushReplacementNamed(context, "/");
            }),
          ],
        ),
        body: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                          image: DecorationImage(
                            image: AssetImage("assets/sellbookbg.jpg"),
                            fit: BoxFit.fill
                          )
                        ),
                      ),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFB74D).withOpacity(0.5),
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 80.0),

                                Container(
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.yellowAccent, width: 4.0),
                                    borderRadius: BorderRadius.circular(7),
                                  ),

                                  child: SizedBox(
                                    height: 70.0,
                                    width: 210.0,
                                    child: RaisedButton(
                                      color: Colors.transparent,
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/sellhome', arguments: {"email" : data["email"]});
                                      },
                                      elevation: 10,
                                      child: Text("Enter as a Seller",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            letterSpacing: 2.0
                                        ),),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                     ]
                    ),
                  ),

                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                            image: DecorationImage(
                                image: AssetImage("assets/buybookbg.jpg"),
                                fit: BoxFit.fill
                            )
                        ),
                      ),

                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF29B6F6).withOpacity(0.5),
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 80.0),

                                Container(
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.red, width: 4.0),
                                    borderRadius: BorderRadius.circular(7),
                                  ),

                                  child: SizedBox(
                                    height: 70.0,
                                    width: 210.0,
                                    child: RaisedButton(
                                      color: Colors.transparent,
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/buyhome', arguments: {"email" : data["email"]});
                                    },
                                      elevation: 10,
                                      child: Text("Enter as a Buyer",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            letterSpacing: 2.0
                                        ),),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ]
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
