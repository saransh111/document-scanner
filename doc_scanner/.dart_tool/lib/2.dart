import 'package:flutter/material.dart';
import 'NewPdf.dart';
import 'UserInterface.dart';
import 'package:url_launcher/url_launcher.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    Icon cur = Icon(Icons.search);
    Widget tops = Text("𝔻𝕆ℂ 𝕊ℂ𝔸ℕℕ𝔼ℝ");
    return Scaffold(
      appBar: AppBar(
        title: tops,
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      drawer: Drawer(
          child: ListView(children: <Widget>[
        DrawerHeader(
            decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage(
              "assets/OIP.jpg",
            ),
          ), //Border.all
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: const Offset(
                5.0,
                5.0,
              ), //Offset
              blurRadius: 3.0,
              spreadRadius: 1.0,
            ), //BoxShadow
            BoxShadow(
              color: Colors.white,
              offset: const Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ), //BoxShadow
          ],
        )),
        ListTile(
            title: Text(
              "Files",
              style: TextStyle(fontSize: 25),
            ),
            onTap: () {
              _launchURLBrowser;
            }),
        ListTile(
            title: Text(
              "Rate Us...",
              style: TextStyle(fontSize: 25),
            ),
            onTap: () {
              _launchURLBrowser;
            }),
        ListTile(
            title: Text(
              "Share App",
              style: TextStyle(fontSize: 25),
            ),
            onTap: () {
              _launchURLBrowser;
            }),
        ListTile(
            title: Text(
              "FAQ",
              style: TextStyle(fontSize: 25),
            ),
            onTap: () {
              _launchURLBrowser;
            }),
        ListTile(
            title: Text(
              "FAQ",
              style: TextStyle(fontSize: 25),
            ),
            onTap: () {
              _launchURLBrowser;
            }),
        ListTile(
            title: Text(
              "FAQ",
              style: TextStyle(fontSize: 25),
            ),
            onTap: () {
              _launchURLBrowser;
            }),
        ListTile(
            title: Text(
              "FAQ",
              style: TextStyle(fontSize: 25),
            ),
            onTap: () {
              _launchURLBrowser;
            }),
        ListTile(
            title: Text(
              "FAQ",
              style: TextStyle(fontSize: 25),
            ),
            onTap: () {
              _launchURLBrowser;
            }),
        ListTile(
            title: Text(
              "ABOUT US",
              style: TextStyle(fontSize: 25),
            ),
            onTap: () {
              _launchURLBrowser;
            })
      ])),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('FAB clicked');
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return doc_scan();
          }));
        },
        tooltip: 'NEW PDF',
        child: Icon(Icons.add),
      ),
      body: myUI(),
    );
  }
  _launchURLBrowser() async {
    const url = 'https://www.geeksforgeeks.org/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
