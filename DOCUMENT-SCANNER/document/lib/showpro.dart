import 'User_model.dart';
import 'package:flutter/material.dart';
import 'database.dart';
import 'package:provider/provider.dart';
import 'load.dart';
// ignore: camel_case_types
class profile extends StatefulWidget {
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            UserData userData = snapshot.data;
            String naam=userData.name;
            String roll=userData.rollno;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'PROFILE',
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w700,
                        //fontStyle: FontStyle.italic,
                        letterSpacing: 4,
                        wordSpacing: 20,
                        //backgroundColor: Colors.yellow,

                    ),
                  ),
                  SizedBox(height: 50.0),
                  Text(
                    'NAME: $naam',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        //fontStyle: FontStyle.italic,
                        letterSpacing: 1,
                        wordSpacing: 2,

                    ),
                  ),
                  SizedBox(height: 30.0),
                  Text(
                    'Roll NO.:$roll',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        //fontStyle: FontStyle.italic,
                        letterSpacing: 1,
                        wordSpacing: 2,
                        //backgroundColor: Colors.yellow,

                    ),
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        }
    );
  }
}
