import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import '2.dart';
import 'UserInterface.dart';


class Splash2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 6,
      navigateAfterSeconds: new SecondScreen(),
      title: new Text('ⒹⓄⒸ ⓈⒸⒶⓃⓃⒺⓇ', textScaleFactor: 2,),
      image: Image.asset(
        "assets/OIP.jpg",
      ),
      loadingText: Text("𝒪𝓊𝓇 𝑅𝒾𝑔𝒽𝓉𝓈 𝒶𝓇𝑒 𝑅𝑒𝓈𝑒𝓇𝓋𝑒𝒹"),
      photoSize: 100.0,
      loaderColor: Colors.blue,
    );
  }
}
