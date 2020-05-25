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
  Widget _buttonDisplay = Text('GO', style: new TextStyle(fontSize: 25.0),);

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _enterPhoneController.dispose();
    super.dispose();
  }


  _query(phone) async {
    if (clickable) {
      setState(() {
        clickable = false;
       _buttonDisplay =  new CircularProgressIndicator(value: null, strokeWidth: 7.0,);
      });

      final response = await http.post('http://34.67.233.153:3000/api/signin',
                headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
                body: jsonEncode(<String, String>{
                'phone': phone,
                }),)
        .timeout(
          Duration(seconds:10),
          onTimeout: (){
           print("143423");
             showError("Network Error, Check connection and try Again.");
              setState(() {
              clickable = true;
              _buttonDisplay =  new  Text('GO', style: new TextStyle(fontSize: 25.0),);
          });
        });

      // check the status code  for the result   
      int statusCode = response.statusCode;

      switch(statusCode){
        case 200:
        try{
          print("response =" + response.body);
           body = jsonDecode(response.body);
           if(body['status']){
           print(body);
              var ss = jsonEncode(<String, String>{
                'phone': body['phone'],
                'name': body['firstname'],
                'user_id': body['uid'],
            });
  
           Credential cred = new Credential.fromJson(jsonDecode(ss));
           print("credn name: ${cred.name}");
           print("credn phone: ${cred.phone}");
           print("credn uid: ${cred.user_id}");
           Provider.of<AppState>(context, listen: false).setCred(cred,false);
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                            return ConfirmCode(body['code']); //skipping code verification till later
                            // return Home();
                          }));
          
          setState(() {
              clickable = true;
              _buttonDisplay =  new  Text('GO', style: new TextStyle(fontSize: 25.0),);
          });
           } else {

           }
        } catch(e){
          print("something went wrong");
          print(e);
          setState(() {
              clickable = true;
              _buttonDisplay =  new  Text('GO', style: new TextStyle(fontSize: 25.0),);
          });
          return false;
        }
          return true;
          case 404:
            setState(() {
              clickable = true;
              _buttonDisplay =  new  Text('GO', style: new TextStyle(fontSize: 25.0),);
          });
          break;
        default:
        showError("Server Error");
        print(statusCode);
        setState(() {
              clickable = true;
              _buttonDisplay =  new  Text('GO', style: new TextStyle(fontSize: 25.0),);
          });
        return false;
      }
  }
  }



 showError(String err){
    showDialog(
    context: context,
    builder: (BuildContext context){
        return AlertDialog(
          title: Text("Alert"),
          content: Text(err),
          actions: <Widget>[
            FlatButton(
              child: Text("Close"),
              onPressed: (){
                  Navigator.of(context).pop();
              },
          )
          ],
        );
    }
    
  );
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
                        if (val.isEmpty) {
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

                      if (_enterPhoneController.value.text.length >= 7 && clickable) {
                        print("going");
                        if (await _query(_enterPhoneController.text)) {
                          print("navigating to confirm code");
                        }
                      } else {
                        print(clickable);
                        showError("Error,  Invalid Phone Number ");
                          setState(() {
                             clickable = true;
                            _buttonDisplay =  new  Text('GO', style: new TextStyle(fontSize: 25.0),);
                          });
                      }

                    }, 
                    child: Container(  
                      height: 50,
                      width: 300,
                      decoration: new BoxDecoration(
                        color: Color.fromRGBO(62, 62, 62, 1),
                        borderRadius: new BorderRadius.circular(5)
                      ),
                      child: new Center(
                        child:_buttonDisplay
                    ), ),
                  ),
                  )
                ]
              )
            ),
          ))
    );
  }
}