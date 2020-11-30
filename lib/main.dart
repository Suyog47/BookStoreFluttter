import 'package:bookonline/Authentications/register.dart';
import 'package:bookonline/Authentications/sign_in.dart';
import 'package:bookonline/Buyer/home.dart';
import 'file:///D:/flutterProjects/book_online/lib/Buyer/PDP/product_page.dart';
import 'package:bookonline/Selection/select.dart';
import 'package:bookonline/Seller/Update/cardview.dart';
import 'package:bookonline/Seller/Upload/category.dart';
import 'package:bookonline/Seller/Upload/image.dart';
import 'package:bookonline/Seller/Upload/price_desc.dart';
import 'package:bookonline/Seller/home.dart';
import 'package:bookonline/UpdateProfile/updation.dart';
import 'package:bookonline/Forget_Password/otp.dart';
import 'package:bookonline/Forget_Password/updatePass.dart';
import 'file:///D:/flutterProjects/book_online/lib/Buyer/PDP/full_image.dart';
import 'file:///D:/flutterProjects/book_online/lib/Buyer/PDP/wishlist.dart';
import 'package:bookonline/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown,DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/wrapper",
      routes: {
        '/wrapper': (context) => Wrapper(),
        '/': (context) => Sign_In(),
        '/register': (context) => Register(),
        '/otp': (context) => Otp(),
        '/upass': (context) => UpdatePass(),
        '/select': (context) => Selection(),
        '/sellhome': (context) => SellHome(),
        '/buyhome': (context) => BuyHome(),
        '/category': (context) => Category(),
        '/img': (context) => Img(),
        '/pricedesc': (context) => PriceDesc(),
        '/updatebook': (context) => BookCards(),
        '/updation': (context) => Updation(),
        '/pdp': (context) => PDP(),
        '/wishlist' : (context) => WishList(),
        '/imgzoom' : (context) => ImageZoom()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

