import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bookonline/Common/book_data.dart';
import 'package:sweetalert/sweetalert.dart';
import 'dart:io' as Io;

class Img extends StatefulWidget {
  @override
  _ImgState createState() => _ImgState();
}

class _ImgState extends State<Img> {

  Map data = {};
  Io.File _image1, _image2, _image3, _image4;

  _imgFromGallery(int i) async {
    dynamic image = (await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    ));

    setState(() {
      (i == 1) ? _image1 = image : (i == 2) ? _image2 = image : (i == 3) ? _image3 = image : _image4 = image;
    });
  }

  BookData dt = BookData();

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    dt = data["data"];

    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Image",
          style: TextStyle(fontFamily: 'BigShoulders', letterSpacing: 2, fontWeight: FontWeight.bold, fontSize: 26),),
        centerTitle: true,
      ),

      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [ Colors.yellow[200], Colors.white]
            )
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),

        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
              children: [
                Container(
                 padding: EdgeInsets.all(5.0),
                 decoration: BoxDecoration(
                   border: Border.all(color: Colors.blueAccent, width: 2.0),
                   borderRadius: BorderRadius.circular(8),
                 ),

                 child: SizedBox(
                   width: 150,
                   height: 190,
                   child: InkWell(
                     onTap: () => _imgFromGallery(1),
                     child: Center(
                       child: (_image1 == null) ?
                       Image(
                           image: AssetImage('assets/no_image.png'),
                           fit: BoxFit.fill
                       ) :
                       Image.file(
                         _image1,
                         fit: BoxFit.fill,
                       ),
                     ),
                   ),
                 ),
              ),

                SizedBox(width: 10),

                Container(
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent, width: 2.0),
                    borderRadius: BorderRadius.circular(8),
                  ),

                  child: SizedBox(
                    width: 150,
                    height: 190,
                    child: InkWell(
                      onTap:() => _imgFromGallery(2),
                      child: Center(
                        child: (_image2 == null) ?
                        Image(
                            image: AssetImage('assets/no_image.png'),
                            fit: BoxFit.fill
                        ) :
                        Image.file(
                          _image2,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                )
              ]
              ),

              SizedBox(height: 10),

              Row(
                  children: [

                    Container(
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent, width: 2.0),
                        borderRadius: BorderRadius.circular(8),
                      ),

                      child: SizedBox(
                        width: 150,
                        height: 190,
                        child: InkWell(
                          onTap: () => _imgFromGallery(3),
                          child: Center(
                            child: (_image3 == null) ?
                            Image(
                                image: AssetImage('assets/no_image.png'),
                                fit: BoxFit.fill
                            ) :
                            Image.file(
                              _image3,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 10),

                    Container(
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent, width: 2.0),
                        borderRadius: BorderRadius.circular(8),
                      ),

                      child: SizedBox(
                        width: 150,
                        height: 190,
                        child: InkWell(
                          onTap: () => _imgFromGallery(4),
                          child: Center(
                            child: (_image4 == null) ?
                            Image(
                                image: AssetImage('assets/no_image.png'),
                                fit: BoxFit.fill
                            ) :
                            Image.file(
                              _image4,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    )
                  ]
              ),

              SizedBox(
                height: 35,
                width: 100,
                child: RaisedButton.icon(
                    onPressed: () {
                      if(_image1 != null && _image2 != null && _image3 != null && _image4 != null) {
                        dt.pic1 = _image1;
                        dt.pic2 = _image2;
                        dt.pic3 = _image3;
                        dt.pic4 = _image4;
                        Navigator.pushNamed(context, "/pricedesc", arguments: {"data": dt});
                      }
                      else{
                        SweetAlert.show(context,
                            subtitle: "Please insert all 4 Images!!",
                            style: SweetAlertStyle.confirm);
                      }
                    },

                    icon: Icon(Icons.keyboard_arrow_right),
                    label: Text("Next"),
                    color: Colors.yellow[500]),
              ),
            ]
        ),
      ),
    );
  }
}
