import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:resturant_reservation/Model/restaurant.dart';
import 'package:resturant_reservation/loading.dart';
import 'package:resturant_reservation/restDetails.dart';

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
  List<Restaurants> data = List<Restaurants>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Out2Night",
          style: TextStyle(
              fontSize: 30, fontFamily: "Pacifico", color: Colors.black),
        ),
      ),
      body: Column(
        children: <Widget>[
          FutureBuilder(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Padding(
                  padding: const EdgeInsets.only(top: 200.0),
                  child: spinkit,
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                  height: MediaQuery.of(context).size.height - 100,
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RestDetails(
                                  name: data[index],
                                ),
                              ));
                        },
                        child: getInfo(data[index]),
                      );
                    },
                  ),
                );
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
          .get("http://opentable.herokuapp.com/api/restaurants?country=ca");

      data = [];
      Map<String, dynamic> map = jsonDecode(response.body);
      List<dynamic> restaurants = map["restaurants"];
      for (int i = 0; i < restaurants.length; i++) {
        Restaurants en = Restaurants.fromJson(restaurants[i]);
        data.add(en);
      }
    } catch (e) {}
  }

  getInfo(Restaurants rest) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 15, bottom: 10),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Container(
          decoration: BoxDecoration(
              color: Color.fromRGBO(68, 66, 81, 10),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, spreadRadius: 5, blurRadius: 9),
              ]),
          child: Stack(
            children: [
              Container(
                //height: 135,
                child: Hero(
                  tag: rest.name,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20)),
                    child: Image.network(
                      rest.imageUrl,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 110,
                top: 10,
                child: Text(
                  rest.name,
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.3,
                  ),
                ),
              ),
              Positioned(
                left: 110,
                top: 40,
                child: Text(
                  rest.address,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white60,
                  ),
                ),
              ),
              Positioned(
                right: 10,
                bottom: 5,
                child: Row(
                  children: [
                    IconButton(icon: Icon(Icons.star), onPressed: null),
                    Text(
                      rest.price.toString(),
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white60,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
