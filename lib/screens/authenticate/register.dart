import 'package:brew_crew/screens/authenticate/sign_in.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:toast/toast.dart';
class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    if (loading == true){
      return Loading();
    }else{
      return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text( "Sign up to baris's app" ),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () {
            widget.toggleView();
          }, icon: Icon(Icons.person), label: Text("Sign In"))
        ],
        ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Email",
                ),
                validator: (val) {
                  if(val.isEmpty)
                  {
                    return "Enter an email";
                  }
                  else{
                    return null;
                  }
                },
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
              },),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "password",
                ),
                validator: (val) {
                  if(val.length <6)
                  {
                    return "Password must be longer than 6 character";
                  }
                  else{
                    return null;
                  }
                },
                obscureText: true,
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
                ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  "Register",
                  style: TextStyle(
                    color: Colors.white,
                  )
                  ),
                onPressed: () async{
                  if(_formKey.currentState.validate()){
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                    if(result == null){
                      setState(() {
                        loading = false;
                        error = "please supply a valid email";
                      });
                    }
                    else
                      {
                        Toast.show(
                            "Succesfully registered as "+email, context, duration: Toast.LENGTH_SHORT,
                            gravity: Toast.BOTTOM);
                      }
                  }
                },
              ),
              SizedBox(height: 20.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
            ),
        )
          
        ),
    );
    }
  }
}