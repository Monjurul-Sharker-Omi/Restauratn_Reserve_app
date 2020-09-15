import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:resturant_reservation/Model/restaurant.dart';
import 'package:resturant_reservation/loading.dart';
import 'package:resturant_reservation/restDetails.dart';

class homepage extends StatefulWidget {
  String value;
  homepage({Key key, @required this.value}) : super(key: key);
  @override
  _homepageState createState() => _homepageState(value);
}

class _homepageState extends State<homepage> {
  String value;
  _homepageState(this.value);

  final CategoriesScroller categoriesScroller = CategoriesScroller();
  ScrollController controller = ScrollController();

  List<Restaurants> data = List<Restaurants>();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(250, 240, 230, 1),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromRGBO(250, 240, 230, 1),
          leading: Icon(
            Icons.menu,
            color: Colors.black,
          ),
          centerTitle: true,
          title: Text(
            "Out2Night",
            style: TextStyle(
                fontSize: 30, fontFamily: "Pacifico", color: Colors.black87),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.person_outline, color: Colors.black),
              onPressed: () {},
            )
          ],
        ),
        body: Container(
          height: screenHeight,
          width: screenWidth,
          child: ListView(
            children: <Widget>[
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(68, 66, 81, 1),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26,
                                spreadRadius: 7,
                                blurRadius: 10),
                          ]),
                      child: categoriesScroller,
                    ),
                  ),
                  FutureBuilder(
                    future: getData(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 100.0),
                          child: spinkit,
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        return Container(
                          //height: screenHeight,
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
                  ),
                ],
              )
            ],
          ),
        ),
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
                top: 20,
                child: Text(
                  rest.name,
                  style: TextStyle(
                    fontSize: 14.5,
                    fontFamily: "sofiapro",
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.3,
                  ),
                ),
              ),
              Positioned(
                left: 110,
                top: 45,
                child: Text(
                  rest.address,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "sofiapro",
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
                        fontFamily: "sofiapro",
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

class CategoriesScroller extends StatelessWidget {
  const CategoriesScroller();

  @override
  Widget build(BuildContext context) {
    final double categoryHeight =
        MediaQuery.of(context).size.height * 0.30 - 50;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: FittedBox(
          fit: BoxFit.fill,
          alignment: Alignment.bottomCenter,
          child: Row(
            children: <Widget>[
              Container(
                width: 150,
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight * 0.70,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 240, 230, .96),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          spreadRadius: 3,
                          blurRadius: 9),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Your\nFavorites",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.black87,
                            fontFamily: "sofiapro",
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 150,
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight * .70,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 240, 230, .96),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          spreadRadius: 3,
                          blurRadius: 9),
                    ]),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Newest",
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.black87,
                              fontFamily: "sofiapro",
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: 150,
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight * .70,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 240, 230, .96),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          spreadRadius: 3,
                          blurRadius: 9),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Special\nOffers",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.black87,
                            fontFamily: "sofiapro",
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 150,
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight * .70,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 240, 230, .9695),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          spreadRadius: 3,
                          blurRadius: 9),
                    ]),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Top\nRated",
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.black87,
                              fontFamily: "sofiapro",
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
