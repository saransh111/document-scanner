import 'package:flutter/material.dart';
import 'NewPdf.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:share/share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_file_manager/flutter_file_manager.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'auth.dart';
import 'database.dart';
import 'load.dart';
import 'package:provider/provider.dart';
import 'User_model.dart';
import 'settings_form.dart';
import 'showpro.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  var files;
  void getFiles() async {
    List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
    var root = storageInfo[0].rootDir;
    var fm = FileManager(root: Directory(root)); //
    files = await fm.filesTree(
        excludedPaths: ["/storage/emulated/0/Android"],
        extensions: ["pdf"] //optional, to filter files, list only pdf files
    );
    setState(() {}); //update the UI
  }
  final AuthService _auth = AuthService();
  @override
  void initState() {
    getFiles(); //call getFiles() function on initial state.
    super.initState();
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var i;
    String naam='User';
    String roll='111me175';
    var atr;
    var currentIndex=0;
    int a = 0;
    var toRemove = [];
    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
        );
      });
      setState(() {});
    }
      void _showprofile() {
       // print("sfsdvsd");
        showModalBottomSheet(context: context, builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: profile(),
          );
        });
        setState(() {});
      }
    User user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            UserData userData = snapshot.data;
            naam=userData.name;
            roll=userData.rollno;
            for (i in files) {
              String str = (i.path.split('/').last);
              if(str.length<8){
                toRemove.add(i);
                continue;
              }
              if (str.substring(0,8).compareTo(roll) != 0) {
                toRemove.add(i);
              }
              a++;
            }
            files.removeWhere((e) => toRemove.contains(e));
            int count = files?.length ?? 0;
            return Scaffold(
              key: _scaffoldKey,
              drawer: Container(
                width: MediaQuery.of(context).size.width / 1.25,
                child: Drawer(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      DrawerHeader(
                        child: Container(
                            height: 142,
                            width: MediaQuery.of(context).size.width,
                            child: CircleAvatar(
                            backgroundImage: AssetImage("assets/2.jpg"),
                        backgroundColor: Colors.red.shade800,
                        radius: 80,
                      )),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          _showprofile();
                        },
                        child: Text(
                          'Profile',
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 45,
                      ),
                      GestureDetector(
                        onTap: () {
                          _showSettingsPanel();
                        },
                        child: Text(
                          'Settings',
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 45,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'About',
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 45,
                      ),
                      GestureDetector(
                        onTap: () async{await _auth.signOut();},
                        child: Text(
                          'Log Out',
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 45,
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(500),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(500),
                          splashColor: Colors.black45,
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.black,
                            child: Icon(Icons.arrow_back, color: Colors.white),
                          ),
                        ),
                      ),
                      Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 65,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.black,
                              child: Center(
                                child: Text(
                                  'v1.0.1',
                                  style: TextStyle(
                                    fontFamily: 'Avenir',
                                    fontSize: 20,
                                    color: const Color(0xffffffff),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
              body: ListView(children: <Widget>[
                  Column(children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          height: 250.0,
                          width: double.infinity,
                          color: Colors.blue,
                        ),
                        Positioned(
                          bottom: 50.0,
                          right: 100.0,
                          child: Container(
                            height: 400.0,
                            width: 400.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(200.0),
                                color: Colors.white.withOpacity(0.4)),
                          ),
                        ),
                        Positioned(
                          bottom: 100.0,
                          left: 150.0,
                          child: Container(
                              height: 300.0,
                              width: 300.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(150.0),
                                  color: Colors.white.withOpacity(0.5))),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 15.0),
                            Row(
                              children: <Widget>[
                                SizedBox(width: 15.0),
                                Container(
                                  alignment: Alignment.topRight,
                                  height: 50.0,
                                  width: 50.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25.0),
                                      border: Border.all(
                                          color: Colors.white,
                                          style: BorderStyle.solid,
                                          width: 2.0),
                                      image: DecorationImage(
                                          image: AssetImage('assets/2.jpg'))),
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width - 120.0),
                                Container(
                                  alignment: Alignment.bottomRight,
                                  child: IconButton(
                                    icon: Icon(Icons.menu_book_rounded),
                                    onPressed: () {
                                      _scaffoldKey.currentState.openDrawer();
                                    },
                                    color: Colors.white,
                                    iconSize: 30.0,
                                  ),
                                ),
                                SizedBox(height: 15.0),
                              ],
                            ),
                            SizedBox(height: 50.0),
                            Padding(
                              padding: EdgeInsets.only(left: 15.0),
                              child: Text(
                                'Hii $naam',
                                style: TextStyle(
                                    fontFamily: 'Quicksand',
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 15.0),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                'How can i help you?',
                                style: TextStyle(
                                    fontFamily: 'Quicksand',
                                    fontSize: 23.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 25.0),
                            Padding(
                              padding: EdgeInsets.only(left: 15.0, right: 15.0),
                              child: Material(
                                elevation: 5.0,
                                borderRadius: BorderRadius.circular(5.0),
                                child: TextFormField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Icon(Icons.search,
                                            color: Colors.blue, size: 30.0),
                                        contentPadding:
                                        EdgeInsets.only(left: 15.0, top: 15.0),
                                        hintText: 'Search',
                                        hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontFamily: 'Quicksand'))),
                              ),
                            ),
                            SizedBox(height: 25.0),
                          ],
                        )
                      ],
                    ),
                    new Container(
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: count,
                          itemBuilder: (BuildContext context,int position){
                            return SizedBox(
                                height: 100.0,
                                child: Card(
                                    margin: EdgeInsets.all(10),
                                    color: Colors.white,
                                    elevation: 3.0,
                                    child: ListTile(
                                      leading: Image.asset(
                                        "assets/R8b0cf36b4cb903a1e92735501fc38464.png",
                                      ),
                                      title: Text((files[position].path.split('/').last)),
                                      subtitle: Text('PDF Document'),
                                      trailing: Wrap(
                                        spacing: 12, // space between two icons
                                        children: <Widget>[
                                          IconButton(
                                            icon: Icon(Icons.open_in_new_sharp),
                                            onPressed: () {
                                              debugPrint("ListTile Tapped");
                                              String path = files[position].path.toString();
                                              OpenFile.open(path);
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.share),
                                            onPressed: () {
                                              debugPrint("ListTile Tapped");
                                              String path = files[position].path.toString();
                                              Share.shareFiles([path], text: '111ME175_ASSIGNMENT');
                                            },
                                          ) // icon-2
                                        ],
                                      ),

                                    )));
                          }
                      ),
                    ),
                  ]
                  ),
                ],),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  debugPrint('FAB clicked');
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return doc_scan();
                  }));
                },
                tooltip: 'NEW PDF',
                child: Icon(Icons.add),//child: Icon(Icons.add),
                backgroundColor: Colors.blue,
                focusColor: Colors.blue,
                foregroundColor: Colors.white,
                hoverColor: Colors.green,
                splashColor: Colors.tealAccent,
              ),
            );
          } else {
            return Loading();
          }
        }
    );
  }
}