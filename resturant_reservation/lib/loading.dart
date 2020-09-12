import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final spinkit = SpinKitChasingDots(
  size: 50,
  itemBuilder: (BuildContext context, int index) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: index.isEven
            ? Color.fromRGBO(141, 137, 169, 3)
            : Color.fromRGBO(68, 66, 81, 3),
      ),
    );
  },
);
