import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:resturant_reservation/Model/restaurant.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var data = List<Restaurants>();

  @override
  Widget build(BuildContext context) {
    //var screenHeight = MediaQuery.of(context).size.height;
    //var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Out2Night"),
      ),
      body: ListView(
        children: <Widget>[
          FutureBuilder(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loadong...");
              } else if (snapshot.connectionState == ConnectionState.done) {
                return Text("Welcome");
              }
            },
          )
        ],
      ),
    );
  }

  getData() async {
    try {
      http.Response response = await http
          .get("http://opentable.herokuapp.com/api/restaurants?country=us");

      data = [];
      Map<String, dynamic> map = jsonDecode(response.body);
      List<dynamic> restaurants = map["restaurants"];
      for (int i = 0; i < restaurants.length; i++) {
        Restaurants en = Restaurants.fromJson(restaurants[i]);
        print(en.reserveUrl);
        print("OMI");
      }
    } catch (e) {}
  }
}
