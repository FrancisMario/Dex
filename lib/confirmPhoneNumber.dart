import 'package:dex/appState.dart';
import 'package:dex/base.dart';
import 'package:dex/dataStructures.dart';
import 'package:dex/fetch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConfirmCode extends StatefulWidget {
   final String correctCode;
   ConfirmCode(this.correctCode,{Key key}) : super(key : key);

    @override 
    _ConfirmCode createState() => _ConfirmCode();

}

class _ConfirmCode extends State<ConfirmCode> {
     // phone textbox box controller
  final _enterCodeController = TextEditingController();
  final _confirmCodeFormKey = GlobalKey<FormState>();
  var _isButtonDisabled = false;
  Color _buttonColor = Color.fromRGBO(62,62,62 ,1);

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
    
    return new Scaffold(
            body: new Container (
                padding: const EdgeInsets.all(30.0),
                // color: Color.fromRGBO(221,44,0, 1),
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
                      SizedBox(height: 1,),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(""),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.of(context).pop();
                                },
                                  child: Text("Didn't recieve code.",style: TextStyle(fontSize:15,color: Colors.blue),),
                              ),
                            ),
                          ],
                        ),
                      SizedBox(height: 10,),

                         FlatButton(
                        color: Colors.green,
                        textColor: Colors.white,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        padding: EdgeInsets.all(8.0),
                        splashColor: Colors.blueAccent,
                        onPressed: () async {
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
                          var cred = Provider.of<AppState>(context, listen: false).cred;
                          Provider.of<AppState>(context, listen: false).setCred(cred,true);
                          Navigator.pushAndRemoveUntil( 
                             context, 
                            MaterialPageRoute(
                                builder: (context) => Home()
                            ), 
                            ModalRoute.withName("/Home"));

                          // Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){return Home();}));
                          print("code is correct");
                      } else { 
                        print(state);
                        setState(() { 
                           _isButtonDisabled = false;
                           _buttonColor = Color.fromRGBO(62,62,62 ,1);
                        });
                        showError("Incorrect Code, Try Again.");
                        print("code is wrong");
                        print(widget.correctCode);
                        print(_enterCodeController.text);
                        }
                      } 
                      }
                        },
                        child: Text(
                                              "Select",
                                                style: TextStyle(fontSize: 20.0),
                                             ),
                      ),

                     ]
                    )
                 ),
            )
            )
            );
  }

  
}