import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PDP extends StatefulWidget {
  @override
  _PDPState createState() => _PDPState();
}

class _PDPState extends State<PDP> {

  Map data = {};
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    data = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(
          title: Text("Product Page",
            style: TextStyle(
                fontFamily: 'RobotoMono',
                fontSize: 20.0,
                letterSpacing: 2.0
            ),),
        ),

        body: Container(
          child: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.fromLTRB(15, 30, 15, 0),

                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 250,
                        child: CarouselSlider(
                          options: CarouselOptions(
                            height: 250.0,
                            aspectRatio: 16/9,
                            enableInfiniteScroll: true,
                            autoPlay: true,
                            scrollDirection: Axis.horizontal,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentIndex = index;
                              });
                            },
                          ),
                          items: [data["pic1"], data["pic2"], data["pic3"], data["pic4"]].map((url) {
                            return Builder(
                              builder: (BuildContext context) {
                                return InkWell(
                                  onTap: (){
                                    Navigator.pushNamed(context, "/imgzoom", arguments: {"img" : url});
                                  },
                                  child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                                      decoration: BoxDecoration(
                                          color: Colors.amber
                                      ),
                                      child: Image.network(
                                          "http://birk-evaluation.000webhostapp.com/" + url,
                                          fit: BoxFit.fill,
                                        ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 8.0,
                            height: 8.0,
                            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentIndex == 0 ? Colors.blueAccent : Colors.grey,
                            ),
                          ),

                          Container(
                            width: 8.0,
                            height: 8.0,
                            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentIndex == 1 ? Colors.blueAccent : Colors.grey,
                            ),
                          ),

                          Container(
                            width: 8.0,
                            height: 8.0,
                            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentIndex == 2 ? Colors.blueAccent : Colors.grey,
                            ),
                          ),

                          Container(
                            width: 8.0,
                            height: 8.0,
                            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentIndex == 3 ? Colors.blueAccent : Colors.grey,
                            ),
                          ),
                        ]
                      ),


                      SizedBox(height: 15.0),
                      Divider(thickness: 1.5,
                        color: Colors.grey,),
                      SizedBox(height: 15.0),


                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(data["standard"] + " ", style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),),

                            SizedBox(width: 10),

                            Text(data["subject"] + " ", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),

                            SizedBox(width: 10),

                            Text("("+data["boards"]+")", style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline)),

                          ]
                      ),

                      SizedBox(height: 20.0),

                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Price: ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14
                              ),),

                            SizedBox(width: 5),

                            Text(data["price"],
                              style: TextStyle(fontSize: 30,
                                  color: Colors.red,
                                  decoration: TextDecoration.underline),),
                          ]
                      ),

                      SizedBox(height: 10.0),
                      Divider(thickness: 1.5,
                        color: Colors.red),
                      SizedBox(height: 10.0),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text("Description: ",
                            style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                                decoration: TextDecoration.underline
                        ),),

                          SizedBox(height: 10),

                          Text(
                              data["description"],
                            style: TextStyle(fontSize: 15)),
                          ]
                      ),

                      SizedBox(height: 5.0),
                      Divider(thickness: 1.5,
                        color: Colors.red,),
                      SizedBox(height: 5.0),

                      Text("Sellers Info: ",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            decoration: TextDecoration.underline
                        ),),

                      SizedBox(height: 25.0),

                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Name: ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17
                              ),),

                            SizedBox(width: 5),

                            Text(data["fullname"], style: TextStyle(fontSize: 17),),
                          ]
                      ),

                      SizedBox(height: 25.0),

                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Email Id: ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17
                              ),),

                            SizedBox(width: 5),

                            Text(data["email"], style: TextStyle(fontSize: 17)),
                          ]
                      ),

                      SizedBox(height: 25.0),

                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Location: ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17
                              ),),

                            SizedBox(width: 5),

                            Text(data["state"], style: TextStyle(fontSize: 17),),
                          ]
                      ),

                      SizedBox(height: 25.0),

                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Phone No: ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17
                              ),),

                            SizedBox(width: 5),

                            Text(data["phoneno"], style: TextStyle(fontSize: 17)),
                          ]
                      ),

                      SizedBox(height: 15.0),
                      Divider(thickness: 1.5,
                        color: Colors.grey,),
                      SizedBox(height: 15.0),
                    ]
                )
            ),
          ),
        )
    );
  }
}
