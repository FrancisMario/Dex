import 'dart:convert';
import 'package:dex/appState.dart';
import 'package:dex/newOrder.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:dex/dataStructures.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

class CashDeposits extends StatefulWidget {

  const CashDeposits({Key key}) : super(key: key);

  _CashDeposits createState()=>_CashDeposits();
}

class _CashDeposits extends State<CashDeposits> {

// TextField Controllers
  TextStyle _namefont  =  new TextStyle(fontFamily: "roboto",fontSize:24);
  TextStyle _valuefont  =  new TextStyle(fontFamily: "roboto",fontSize:15);
  var _bank = null;
  var _amount = null;
  String _pickup_date = "Delivery Date";
  String _pickup_time = "Delivery Time";

  var  dateFormater =  new DateFormat('dd-MM');

    
   _pickDate() async {
   DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().day),
      lastDate: DateTime(DateTime.now().day+30),
      initialDate: DateTime(DateTime.now().day),
    );
    if(date != null)
      setState(() {
        _pickup_date = dateFormater.format(date);
      });
  }

 _pickTime() async {
   TimeOfDay t = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if(t != null)
      setState(() {
        _pickup_time = t.format(context);
      });
  }

  showSuccess(String str){
    showDialog(
    context: context,
    builder: (BuildContext context){
        return AlertDialog(
          title: Text("Success"),
          content: Text(str),
        );
    }
  );
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
   _sendOrder() async {

Dio dio = new Dio();
dio.options.baseUrl = dio.options.baseUrl = Provider.of<AppState>(context, listen: false).serverUrl;;

// Optionally the request above could also be done as
var response = await dio.post("/cashorder", data: 

  jsonEncode(<String, String>{
      /**
       */
      'user_id': Provider.of<AppState>(context, listen: false).cred.user_id,
      'bank': _bank,
      'pickup_date': _pickup_time,
      'pickup_time': _pickup_date,
      'amount': _amount,
    })

).timeout(Duration(seconds: 10),onTimeout: (){
      showError("NetWork Error, Please Try Again");
  });

     switch (response.statusCode) {
          case 200:
            showSuccess("Order Was successfully placed");
            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                           return NewOrder(); //Going back to the new order start page
            }));
          break;
          case 403:
            showError("Please Fill all inputs");
          break;
          default:
            showError("Server Error, please try again later. /n error code: ${response.statusCode}");
          break;
        }
  }
  


  @override 
  Widget build(BuildContext context) {
    
  return Scaffold(
  appBar: AppBar(title: Text("Delivery Details"),),
  body: Column(
    children: <Widget>[
        Padding(padding: EdgeInsets.only(top:50),),
     Center(
       child:
        Container(
         width: 250, 
          child:
           Column(
              children:<Widget>[
                Padding(padding: EdgeInsets.only(top:20),),

                Padding(padding: EdgeInsets.only(top:10),),

              Row(
                children: <Widget>[
                     Expanded(
                        flex: 5,
                        child:
                        FlatButton(
                          onPressed: _pickDate, 
                          child: Container(
                            width: 100,
                            height: 50,
                            color: Colors.amber,
                    child: Center(child: Text(_pickup_date))
                  )
          ),
       ),
            // Expanded(flex:1,child: null),
    Expanded(
        flex: 5,
        child:
          FlatButton(
            onPressed:_pickTime, 
            child: Container(
                    width: 100,
                    height: 50,
                    color: Colors.amber,
                    child: Center(child: Text(_pickup_time))
                  )
          ),
    )
  ],
),

                  Padding(padding: EdgeInsets.only(top:10),),
          
                    TextField(
                   onChanged: (text){
                           _bank = text;
                        },
                   style: TextStyle(fontSize: 20),
                   decoration: InputDecoration(
                      hintText: "Bank Name",
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(
                              color: Colors.teal,
                            ),
                          ),
                      prefixIcon: const Icon(
                            Icons.security,
                            color: Colors.white,
                          ),
                  ),
                ),
                  Padding(padding: EdgeInsets.only(top:10),),

                 TextField(
                   onChanged: (text){
                           _bank = text;
                        },
                   style: TextStyle(fontSize: 20),
                   decoration: InputDecoration(
                     labelText: "Amount",
                      hintText: "Amount",
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(
                              color: Colors.teal,
                            ),
                          ),
                      prefixIcon: const Icon(
                            Icons.security,
                            color: Colors.white,
                          ),
                  ),
                ),



  Row(
    children: <Widget>[
  
    Expanded(
        flex: 5,
        child:
          FlatButton(
            onPressed: (){
              _sendOrder();
            }, 
            child: Container(
                    width: 150,
                    height: 50,
                    color: Colors.amber,
                    child: Center(child: Text("Next"))
                  )
          ),
    )
  ],
)



              ]
           ),
       ),
     ),

    ],
  ),
);

  }


}



