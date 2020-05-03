import 'dart:convert';

import 'package:dex/appState.dart';
import 'package:dex/base.dart';
import 'package:dex/confirmPhoneNumber.dart';
import 'package:dex/dataStructures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'
as http;
import 'package:provider/provider.dart';


/**
 * class SetPhoneNumber
 * this class  collects and authenticates the phone number of the user
 * 
 */
class SetPhone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Body(),
    );
  }
}

class Body extends StatefulWidget {
  @override
  _Body createState() => _Body();
}

class _Body extends State < Body > {
  // phone textbox box controller
  final _enterPhoneController = TextEditingController();
  //phone textbox key
  final _enterPhoneFormKey = GlobalKey < FormState > ();
  //correct code from server
  String _code = null;
  Map<String,dynamic> body = null;
  var clickable = true;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _enterPhoneController.dispose();
    super.dispose();
  }

  Future<void> _neverSatisfied() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Rewind and remember'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('You will never be satisfied.'),
              Text('You\’re like me. I’m never satisfied.'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Regret'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}



  _query(phone) async {
    if (clickable) {
      clickable = false;
      final response = await http.get('http://192.168.137.1/verify_phone/verify.php?phone=${phone}');
      // check the status code  for the result   
      int statusCode = response.statusCode;

      switch(statusCode){
        case 408 :
        break;
        case 200:
        try{
          print(response.body);
           body = jsonDecode(response.body);
           print(body);
           Credential cred = new Credential.fromJson(body);
           Provider.of<AppState>(context, listen: false).setCred(cred);
          print("everthing Okaay");
          clickable = true;
        } catch(e){
          print("something went wrong");
          print(e);
          clickable = true;
          return false;
        }
          return true;
        default:
        return false;
      }
  }
  }






  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Container(
        padding: const EdgeInsets.all(30.0),
          color: Color.fromRGBO(221, 44, 0, 1),
          child: new Container(
            child: new Center(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //  new Padding(padding: EdgeInsets.only(top: 100.0)),
                  new Center(
                    child: Text('Enter phone To Login', style: new TextStyle(color: Colors.blue, fontSize: 20.0, fontFamily: "roboto"), )
                  ),
                  new Padding(padding: EdgeInsets.only(top: 20.0)),
                  Form(
                    key: _enterPhoneFormKey,
                    child: new TextFormField(
                      maxLength: 7,
                      controller: _enterPhoneController,
                      decoration: new InputDecoration(
                        labelText: "Enter Phone",
                        fillColor: Color.fromRGBO(62, 62, 62, 1),
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                          borderSide: new BorderSide(),
                        ),
                      ),
                      validator: (val) {
                        if (val.length == 0) {
                          return "phone cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.phone,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                  new Padding(padding: EdgeInsets.only(top: 10.0)),
                  GestureDetector(
                    child: FlatButton(onPressed: () async {
                      if (_enterPhoneFormKey.currentState.validate() && clickable) {
  
                        print("going");
                        if (await _query(_enterPhoneController.text)) {
                          print("navigating to confirm code");

                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                            // return ConfirmCode("1000"); skipping code verification till later
                            return Home();
                          }));
                        } else {
                          return Container(height: 200, width: 200, decoration: BoxDecoration(
                            color: Colors.black12,
                          ), );
                        }
                      }
                    }, child: Container(
                      height: 50,
                      width: 300,
                      decoration: new BoxDecoration(
                        color: Color.fromRGBO(62, 62, 62, 1),
                        borderRadius: new BorderRadius.circular(5)
                      ),
                      child: new Center(
                        child: Text('GO',
                          style: new TextStyle(fontSize: 25.0),
                        ),
                      ),
                    ), ),
                  )
                ]
              )
            ),
          ))
    );
  }
}