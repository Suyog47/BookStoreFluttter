import 'package:flutter/material.dart';
import 'package:bookonline/Cache_Calls/log_status.dart';

class SellHome extends StatelessWidget {
  Map data = {};
  GetSetLogStatus cache = GetSetLogStatus();

  @override
  Widget build(BuildContext context) {

    data = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Book Seller",
            style: TextStyle(fontFamily: 'BigShoulders', letterSpacing: 2, fontWeight: FontWeight.bold, fontSize: 26)),
        actions: [
          IconButton(icon: Icon(Icons.power_settings_new, color: Colors.red,),
              onPressed: () async {
                cache.deleteLoginStatus();
                Navigator.pushReplacementNamed(context, "/");
              }),
        ],
    ),

      body: Container(
       padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            
            Container(
              padding: EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                border: Border.all(color: Colors.blueAccent, width: 2.0),
                borderRadius: BorderRadius.circular(20),
              ),

              child: Center(
                child: Column(
                 children: [
                   Text("Want to upload books?",
                   style: TextStyle(
                     fontSize: 18.0,
                     fontStyle: FontStyle.italic
                   ),),

                   SizedBox(height: 30.0),

                   InkWell(
                     onTap: (){
                       Navigator.pushNamed(context, "/category", arguments: {"email" : data["email"], "task": "insert"});
                     },
                     child: Container(
                       padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(20.0),
                         gradient: LinearGradient(
                           begin: Alignment.topRight,
                           end: Alignment.bottomLeft,
                           colors: [ Colors.blue, Colors.red]
                         )
                       ),
                       child: Text("Upload Book",
                         style: TextStyle(
                             color: Colors.white,
                             fontWeight: FontWeight.bold,
                             fontSize: 17)),
                     ),
                   )
                 ],
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.blueAccent, width: 2.0),
              ),

              child: Center(
                child: Column(
                  children: [
                    Text("Want to watch uploaded books?",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontStyle: FontStyle.italic
                      ),),

                    SizedBox(height: 30.0),

                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, "/updatebook", arguments: {"email" : data["email"]});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [ Colors.yellow, Colors.red]
                            )
                        ),
                        child: Text("Watch Uploaded Books",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17)),
                      ),
                    )
                  ],
                ),
              ),
            )
          ]
        ),

      ),
    );
  }
}

