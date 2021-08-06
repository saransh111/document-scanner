import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/abc.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SpinKitChasingDots(
            color: Colors.blue,
            size: 50.0,
          ),
        ),
      ),
    );
  }
}