import 'package:flutter/material.dart';
import 'package:resturant_reservation/Model/restaurant.dart';
import 'package:resturant_reservation/reserve.dart';

class RestDetails extends StatefulWidget {
  final Restaurants name;
  RestDetails({this.name});
  @override
  _RestDetailsState createState() => _RestDetailsState();
}

class _RestDetailsState extends State<RestDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(249, 238, 226, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(249, 238, 226, 1),
        centerTitle: true,
        title: Text(
          "Out2Night",
          style: TextStyle(
              fontSize: 30, fontFamily: "Pacifico", color: Colors.black),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Hero(
            tag: widget.name.name,
            child: Image.network(
              widget.name.imageUrl,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              widget.name.name,
              style: TextStyle(
                fontSize: 40,
                fontFamily: "sofiapro",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 8),
            child: Text(
              widget.name.city,
              style: TextStyle(
                fontSize: 30,
                fontFamily: "sofiapro",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "Address: " + widget.name.address,
              style: TextStyle(
                fontSize: 20,
                fontFamily: "sofiapro",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "Contact:" + widget.name.phone,
              style: TextStyle(
                fontSize: 20,
                fontFamily: "sofiapro",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Row(
              children: [
                Text(
                  "Ratings:  " + widget.name.price.toString(),
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: "sofiapro",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(icon: Icon(Icons.star_border), onPressed: null),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: RaisedButton(
                color: Colors.white,
                textColor: Colors.black,
                highlightColor: Color.fromRGBO(190, 188, 203, 1),
                splashColor: Color.fromRGBO(87, 89, 101, 1),
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 80),
                elevation: 10,
                highlightElevation: 30,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Reserveweb(mobileReserveUrl: widget.name),
                      ));
                },
                child: Text(
                  "Book Online",
                  style: TextStyle(
                    fontFamily: "sofiapro",
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
