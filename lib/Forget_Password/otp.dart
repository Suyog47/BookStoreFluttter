import 'dart:math';
import 'package:bookonline/Common/network_connectivity_status.dart';
import 'package:flutter/material.dart';
import 'package:bookonline/Decorations/input_decoration.dart';
import 'package:flutter/services.dart';
import 'package:mailer/mailer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bookonline/Decorations/loader.dart';
import 'package:sweetalert/sweetalert.dart';

class Otp extends StatefulWidget {
  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {

  String i1 = '', i2 = '', i3 = '', i4 = '', i5 = '';
  bool t, btn1 = true;
  String _email = '';
  int rand;
  bool ld = false;
  NetworkCheck net = new NetworkCheck();

  void checkEmail() async {
    var url = "https://birk-evaluation.000webhostapp.com/check_email.php";
    var data = {
      "email" : _email,
    };
    var response = await http.post(url, body: data);
    var res = jsonDecode(response.body);
    if(res){
      setState(() => t = true);
      sendOtp();
    }
    else{
      setState(() {
        ld = false;
        Fluttertoast.showToast(msg: "This Email is not registered", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 17);
      });
    }
  }

  void sendOtp() async {
    int min = 10000;
    int max = 99999;
    var randomizer = new Random();
    rand = min + randomizer.nextInt(max - min);
   // rand = int.parse(randomNumeric(5));

    String username = 'suyogamin11@gmail.com';
    String password = 'fc.barcelona.city@12345';

    final smtpServer = gmail(username, password);

    // Create our message.
    final message = Message()
      ..from = Address(username, 'Book Online Store')
      ..recipients.add(_email)
      ..subject = 'This is Your OTP...Enjoy '
      ..html = "<h2>Your OTP is:- </h2><b>$rand</b>";


    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      setState(() {
        ld = false;
        btn1 = false;
        Fluttertoast.showToast(msg: "Otp sent to ur Email... Put it here", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER, backgroundColor: Colors.green, textColor: Colors.white, fontSize: 17);});
    } on MailerException catch (e) {
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
        Fluttertoast.showToast(msg: "Something went wrong while sending otp", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM, backgroundColor: Colors.red, textColor: Colors.white);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Update Profile",
          style: TextStyle(fontFamily: 'BigShoulders', letterSpacing: 2, fontWeight: FontWeight.bold, fontSize: 26),),
        centerTitle: true,
      ),

      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.blue, Colors.pinkAccent]
            )
        ),

        child: Column(
          children: [
            Text("Enter your Registered Email", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, letterSpacing: 2.0, color: Colors.white)),

            SizedBox(height: 40),

            TextFormField(
              decoration: textInputDecoration.copyWith(hintText: 'Email Id:'),
              onChanged: (val) => _email = val.trim(),
            ),

            SizedBox(height: 40),

            SizedBox(
              height: 40,
              width: 130,
              child: RaisedButton(
                  onPressed: () async {
                    if(btn1 && _email.isNotEmpty && RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(_email)) {
                      int stat = await net.checkNetwork();
                      if(stat == 1) {
                        setState(() => ld = true);
                        checkEmail();
                      }
                      else{
                        Fluttertoast.showToast(msg: "Please connect to Internet first", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.TOP, backgroundColor: Colors.orange, textColor: Colors.black, fontSize: 17);
                      }
                    }
                    },
                    child: Text("Send Otp"),
                    color: Colors.yellow[500]),
                    ),

                    SizedBox(height: 20),

                    OtpLoader(ld: ld),

                    SizedBox(height: 20),

                    Row(
                    children: [
                    SizedBox(
                    width: 50,
                    child: TextFormField(
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    decoration: otpTextDecoration.copyWith(hintText: '*'),
                    enabled: t,
                    keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLength: 1,
                    onChanged: (val) {
                      i1 = val;
                      if(i1 != null && i1 != ""){FocusScope.of(context).nextFocus();}
                    },
                  ),
                ),

                SizedBox(width: 20),

                SizedBox(
                  width: 50,
                  child: TextFormField(
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    enabled: t,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textInputAction: TextInputAction.next,
                    decoration: otpTextDecoration.copyWith(hintText: '*'),
                    maxLength: 1,
                    onChanged: (val) {
                      i2 = val;
                      if(i2 != null && i2 != ""){FocusScope.of(context).nextFocus();}
                    },
                  ),
                ),

                SizedBox(width: 20),

                SizedBox(
                  width: 50,
                  child: TextFormField(
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                    maxLines: 2,
                    enabled: t,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textInputAction: TextInputAction.next,
                    decoration: otpTextDecoration.copyWith(hintText: '*'),
                    maxLength: 1,
                    onChanged: (val) {
                      i3 = val;
                      if(i3 != null && i3 != ""){FocusScope.of(context).nextFocus();}
                    },
                  ),
                ),

                SizedBox(width: 20),

                SizedBox(
                  width: 50,
                  child: TextFormField(
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                    maxLines: 2,
                    enabled: t,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textInputAction: TextInputAction.next,
                    decoration: otpTextDecoration.copyWith(hintText: '*'),
                    maxLength: 1,
                    onChanged: (val) {
                      i4 = val;
                      if(i4 != null && i4 != ""){FocusScope.of(context).nextFocus();}
                    },
                  ),
                ),

                SizedBox(width: 20),

                SizedBox(
                  width: 50,
                  child: TextFormField(
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                    maxLines: 2,
                    enabled: t,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textInputAction: TextInputAction.next,
                    decoration: otpTextDecoration.copyWith(hintText: '*'),
                    maxLength: 1,
                    onChanged: (val) {
                      i5 = val;
                      setState(() {
                        i5 = i5;
                      });
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: 70),

            SizedBox(
              height: 45,
              width: 400,
              child: RaisedButton(
                color: Colors.green,
                child: Text("Check Otp", style: TextStyle(color: Colors.white, fontSize: 18)),
                onPressed: () {
                  if(i5 != "" && i5 != null) {
                    int otp = int.parse(i1+i2+i3+i4+i5);

                    if(otp == rand) {
                      Navigator.pushReplacementNamed(context, "/upass", arguments: {"email" : _email});
                    }
                    else{
                      SweetAlert.show(context, subtitle: "Wrong Otp entered.... Enter again",
                          style: SweetAlertStyle.error);
                    }
                  }
                else{ return null; }
                }
              ),
            ),
          ],
        ),
      )
    );
  }
}
