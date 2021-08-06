import 'User_model.dart';
import 'package:flutter/material.dart';
import 'database.dart';
import 'package:provider/provider.dart';
import 'load.dart';
class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();

  // form values
  String _currentName;
  String _currentroll;

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            UserData userData = snapshot.data;
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Update your brew settings.',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      initialValue: userData.name,
                      validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                      onChanged: (val) => setState(() => _currentName = val),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      initialValue: userData.rollno,
                      validator: (val) => val.isEmpty ? 'Please enter a roll no' : null,
                      onChanged: (val) => setState(() => _currentroll = val),
                    ),
                    RaisedButton(
                        color: Colors.pink[400],
                        child: Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if(_formKey.currentState.validate()){
                            await DatabaseService(uid: user.uid).updateUserData(
                                _currentroll ?? snapshot.data.rollno,
                                _currentName ?? snapshot.data.name,
                            );
                            Navigator.pop(context);
                          }
                        }
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Loading();
          }
        }
    );
  }
}