import 'dart:convert';

import 'package:dex/appState.dart';
import 'package:dex/base.dart';
import 'package:dex/confirmPhoneNumber.dart';
import 'package:dex/dataStructures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'
as http;
import 'package:provider/provider.dart';


/**
 * class SetPhoneNumber
 * this class  collects and authenticates the phone number of the user
 * 
 */
class SetPhone extends StatelessWidget {

  SetPhone({Key key}) : super(key: key);
  
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
  final _enterNameController = TextEditingController();
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

      _error(String err){
      showError(err);
              setState(() {
                clickable = true;
                _buttonDisplay =  new  Text('GO', style: new TextStyle(fontSize: 25.0),);
              });
      }
       


  _query(phone,name) async {
    if (clickable) {
      setState(() {
        clickable = false;
       _buttonDisplay =  new CircularProgressIndicator(value: null, strokeWidth: 7.0,);
      });
  String url = Provider.of<AppState>(context, listen: false).serverUrl;
      print("object");
  var response = await http.post(
    "$url/market/loginUser.php",
      body:{"name":name,"phone":phone}) 
     .timeout(Duration(seconds: 10),onTimeout: (){  
      //  print("143423");
      _error("Network Error q.!");
            
    }).catchError((onError){
      print("onError");
      print(onError);
      _error("Network Error.!");
    });

      print("object 1");

      switch(response.statusCode){
        case 200:
        try{
           body = jsonDecode(response.body);
           print(body);
          if(body['status'] == "200"){
              Credential cred = new Credential.fromJson(body);
              print("credn name: ${cred.name}");
              print("credn phone: ${cred.phone}");
              print("credn uid: ${cred.user_id}");
              print("credn uid: ${body['code']}");  
              Provider.of<AppState>(context, listen: false).setCred(cred,false);
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                            return ConfirmCode(body['code'],key: widget.key,); //skipping code verification till later
                            // return Home();
                          }));
            }
          _error("Server Error");
          setState(() {
              clickable = true;
              _buttonDisplay =  new  Text('GO', style: new TextStyle(fontSize: 25.0),);
          });
           
        } catch(e){
          print("something went wrong");
          print(e);
          _error("Possible Server Error.");
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
        _error("Possible Server Error.");
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
          // color: Color.fromRGBO(221, 44, 0, 1),
          child: new Container(
            child: new Center(
              child: new ListView(
                children: [
                  //  new Padding(padding: EdgeInsets.only(top: 100.0)),
                  SizedBox(height: 100,),
                  new Center(
                    child: Text('Enter phone To Login', style: new TextStyle(color: Colors.blue, fontSize: 20.0, fontFamily: "roboto"), )
                  ),
                  new Padding(padding: EdgeInsets.only(top: 20.0)),
                  Form(
                    key: _enterPhoneFormKey,
                    child: Column(
                      children:<Widget>[
                       new TextFormField(
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
                      SizedBox(height: 10,),
                       new TextFormField(
                        controller: _enterNameController,
                        decoration: new InputDecoration(
                          labelText: "Enter FullName",
                          fillColor: Color.fromRGBO(62, 62, 62, 1),
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        validator: (val) {
                          if (val.isEmpty) {
                            return "name cannot be empty";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.text,
                        style: new TextStyle(
                          fontFamily: "Poppins",
                        ),
                      ),
                      ]
                    ),

                  ),
                  SizedBox(height:10),
                   FlatButton(
                        color: Colors.green,
                        textColor: Colors.white,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        padding: EdgeInsets.all(8.0),
                        splashColor: Colors.blueAccent,
                        onPressed: () async {
                      if (_enterPhoneController.value.text.length >= 7 && clickable && _enterNameController.value.text.length >= 4) {
                        print("going");
                        if (await _query(_enterPhoneController.text,_enterNameController.text)) {
                          print("phone ${_enterPhoneController.text}");
                          print("name ${_enterNameController.text}");
                          print("navigating to confirm code");
                        }
                        print("going failed");
                      } else {
                        print(clickable);
                        showError("Error,  Invalid Phone Number ");
                          setState(() {
                             clickable = true;
                            _buttonDisplay =  new  Text('GO', style: new TextStyle(fontSize: 25.0),);
                          });
                      }
                        },
                        child: _buttonDisplay
                      ),
                ]
              )
            ),
          ))
    );
  }
}