import 'package:dex/appState.dart';
import 'package:dex/base.dart';
import 'package:dex/dataStructures.dart';
import 'package:dex/fetch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConfirmCode extends StatefulWidget {
   final String correctCode;
   ConfirmCode(this.correctCode);

    @override 
    _ConfirmCode createState() => _ConfirmCode();

}

class _ConfirmCode extends State<ConfirmCode> {
     // phone textbox box controller
  final _enterCodeController = TextEditingController();
  final _confirmCodeFormKey = GlobalKey<FormState>();
  var _isButtonDisabled = false;
  Color _buttonColor = Color.fromRGBO(62,62,62 ,1);

  
  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
            body: new Container (
                padding: const EdgeInsets.all(30.0),
                color: Color.fromRGBO(221,44,0, 1),
                child: new Container(
                  child: new Center(
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                     children : [
                      //  new Padding(padding: EdgeInsets.only(top: 100.0)),
                       new Center(
                         child: Text('Enter confirmation code to continue', style: new TextStyle(color: Colors.blue, fontSize: 20.0,fontFamily: "roboto" ),)
                       ),
                       new Padding(padding: EdgeInsets.only(top: 20.0)),
                       
                       
                       Form(
                         key: _confirmCodeFormKey,
                       child: new TextFormField(
                         maxLength: 6,
                          controller: _enterCodeController,
                      decoration: new InputDecoration(
                        labelText: "Enter Code",
                        fillColor: Color.fromRGBO(62,62,62, 1), 
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                          borderSide: new BorderSide(
                          ),
                        ),
                        //fillColor: Colors.green
                      ),
                      validator: (val) {
                        if(val.length==0) {
                          return "Email cannot be empty";
                        }else{
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
                    child: FlatButton(onPressed: (){
                      if(!_isButtonDisabled){
                        setState(() {
                        _isButtonDisabled = true;
                        _buttonColor = Color.fromRGBO(98, 101, 103 ,1);
                        });
                      if(_confirmCodeFormKey.currentState.validate()){
                       var state = _enterCodeController.text.toString().toLowerCase().trim() == widget.correctCode.toString().toLowerCase().trim();
                      if (state) {
                          // saving user to device
                          // Provider.of<AppState>(context, listen: true).;

                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){return Home();}));
                          print("code is correct");
                      } else { 
                        print(state);
                        setState(() { 
                           _isButtonDisabled = false;
                           _buttonColor = Color.fromRGBO(62,62,62 ,1);
                        });
                        print("code is wrong");
                        print(widget.correctCode);
                        print(_enterCodeController.text);
                        }
                      } 
                      }
                    }, child: Container(
                      height: 50,
                      width: 300,
                      decoration: new BoxDecoration(
                        color: _buttonColor,
                        borderRadius: new BorderRadius.circular(5)
                      ),
                      child: new Center(
                        child:Text('GO',
                           style: new TextStyle(fontSize: 25.0),
                        ),
                      ),
                    ),
                    ),
                      )
                     ]
                    )
                 ),
            )
            )
            );
  }

  
}