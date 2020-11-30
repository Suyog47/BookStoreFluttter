import 'package:flutter/material.dart';

class ImageZoom extends StatefulWidget {
  @override
  _ImageZoomState createState() => _ImageZoomState();
}

class _ImageZoomState extends State<ImageZoom> {
  Map data = {};
  String url;

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    url = "http://birk-evaluation.000webhostapp.com/" + data["img"];

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          decoration: BoxDecoration(color: Colors.black),
          child:
          Center(
            child: InteractiveViewer(
              boundaryMargin: EdgeInsets.all(30.0),
              minScale: 0.5,
              maxScale: 6.0,
              child: Image.network(url),
          ),
          )
        )
      )
      );
  }
}
