import 'package:flutter/material.dart';
import 'package:resturant_reservation/Model/restaurant.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Reserveweb extends StatefulWidget {
  final Restaurants mobileReserveUrl;
  Reserveweb({Key key, @required this.mobileReserveUrl}) : super(key: key);
  @override
  _ReservewebState createState() => _ReservewebState();
}

class _ReservewebState extends State<Reserveweb> {
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
      body: WebView(
        initialUrl: widget.mobileReserveUrl.mobileReserveUrl,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
