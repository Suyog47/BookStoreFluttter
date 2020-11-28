import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class OtpLoader extends StatelessWidget {

  bool ld;
  OtpLoader({this.ld});

  @override
  Widget build(BuildContext context) {
    return ld ? Container(
      child: Center(
        child: SpinKitCircle(
        color: Colors.white,
        size: 38.0,
      ),
      ),
    ) : SizedBox();
  }
}

class WishlistLoader extends StatelessWidget {

  bool ld;
  WishlistLoader({this.ld});

  @override
  Widget build(BuildContext context) {
    return ld ? Container(
      child: Center(
        child: SpinKitCircle(
          color: Colors.black,
          size: 35.0,
        ),
      ),
    ) : SizedBox();
  }
}

class Loader extends StatelessWidget {

  final int load;
  Loader({this.load});

  @override
  Widget build(BuildContext context) {
    return (load == 1) ?
    Container(
      color: Colors.black.withOpacity(0.5),
      child: SpinKitCircle(
        color: Colors.blue,
        size: 60.0,
      ),
    ) :
    Text("");
  }
}
