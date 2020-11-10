// LOADING WIDGET
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          color: Colors.lightBlueAccent.withOpacity(0.4),
          child: SpinKitFadingCube(
            color: Color.fromRGBO(51, 129, 239,1.0),
            size: 60,
          ),
        ),
      ),
    );
  }
}
