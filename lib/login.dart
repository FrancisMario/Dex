import 'package:dex/setPhoneNumber.dart';
import 'package:flutter/material.dart';
class Login extends StatefulWidget {

  Login({Key key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        title:Text("Login"),
        ),
        body:
         SetPhone(key:widget.key,),
    ); 
  }
}
