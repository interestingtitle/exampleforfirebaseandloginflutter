import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text("Baris's app"),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () async{
                await _auth.signOut();
                Toast.show(
                    "Signed out ", context, duration: Toast.LENGTH_SHORT,
                    gravity: Toast.BOTTOM);
              } , 
              icon: Icon(Icons.person), 
              label: Text("Logout")
              )
          ],
        ),
        ),
    );
  }
}