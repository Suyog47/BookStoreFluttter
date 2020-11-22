import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageZoom extends StatefulWidget {
  @override
  _ImageZoomState createState() => _ImageZoomState();
}

class _ImageZoomState extends State<ImageZoom> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    print(data);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          decoration: BoxDecoration(color: Colors.black),

          child: SizedBox(
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: "http://birk-evaluation.000webhostapp.com/" + data["img"],
              imageBuilder: (context, imageProvider) => PhotoView(
                imageProvider: imageProvider,
              ),
              placeholder: (context, url) =>
                  CircularProgressIndicator(),
              errorWidget: (context, url, error) =>
                  Icon(Icons.error),
            ),
          )

        ),
      ),
    );
  }
}
