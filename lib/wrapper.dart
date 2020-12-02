import 'dart:async';
import 'package:flutter/material.dart';
import 'package:bookonline/Cache_Calls/log_status.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  GetSetLogStatus cache = GetSetLogStatus();

  void loginCheck() async {
   dynamic res = await cache.getLoginStatus();
   if(res != false){
     if(!mounted) return;
     Navigator.pushReplacementNamed(context, "/select", arguments: {"email" : res});
   }
   else{
     if(!mounted) return;
     Navigator.pushReplacementNamed(context, "/");
   }
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 6), () {
      loginCheck();
    });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
               image: AssetImage("assets/book1bg.jpg"), fit: BoxFit.fill)
        ),

        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage("assets/bookicon.png"),
                      height: 60,
                      width: 60,),
                    SizedBox(width: 10),
                    Text("Shop for School Books", style: TextStyle(color: Colors.red, letterSpacing: 2, fontSize: 24, fontFamily: 'NerkoOne')),
                  ],
                )
              ),
              SpinKitCircle(
                color: Colors.red,
                size: 60.0,
              )
            ],
          ),
        )
      ),
    );
  }
}


