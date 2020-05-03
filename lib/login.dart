import 'package:dex/setPhoneNumber.dart';
import 'package:flutter/material.dart';
class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        title:Text("Login"),
        ),
        body:
         SetPhone(),
    ); 
  }
}
