//import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:resturant_reservation/homepage.dart';
// import 'package:http/http.dart' as http;
// import 'package:resturant_reservation/Model/restaurant.dart';
// import 'package:resturant_reservation/loading.dart';
// import 'package:resturant_reservation/restDetails.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      theme: new ThemeData(primarySwatch: Colors.blue),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  //List<Restaurants> data = List<Restaurants>();
  AnimationController iconanimctrl;
  Animation<double> iconanim;
  String value;

  @override
  void initState() {
    super.initState();
    iconanimctrl = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    iconanim = new CurvedAnimation(parent: iconanimctrl, curve: Curves.easeOut);
    iconanim.addListener(() => this.setState(() {}));
    iconanimctrl.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Image(
            image: AssetImage("assets/rest.jpg"),
            fit: BoxFit.cover,
            color: Colors.black54,
            colorBlendMode: BlendMode.darken,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Out2Night",
                style: TextStyle(
                    fontSize: iconanim.value * 50,
                    fontFamily: "Pacifico",
                    color: Colors.white60),
              ),
              Form(
                child: Theme(
                  data: ThemeData(
                      brightness: Brightness.dark,
                      primarySwatch: Colors.teal,
                      inputDecorationTheme: InputDecorationTheme(
                          labelStyle: TextStyle(
                              color: Colors.tealAccent, fontSize: 20))),
                  child: Container(
                    padding: EdgeInsets.all(40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          onChanged: (text) {
                            value = text;
                          },
                          decoration: InputDecoration(
                            hintText: "Enter Name",
                          ),
                          keyboardType: TextInputType.name,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: "Enter Number",
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        Padding(padding: EdgeInsets.only(top: 40)),
                        RaisedButton(
                          color: Colors.white60,
                          textColor: Colors.white,
                          highlightColor: Colors.greenAccent,
                          splashColor: Colors.cyanAccent,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 30),
                          elevation: 10,
                          highlightElevation: 30,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontFamily: "sofiapro",
                                fontSize: 20,
                                color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => homepage(value: value),
                                ));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
