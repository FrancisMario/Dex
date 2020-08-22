import 'dart:convert';
import 'package:dex/appState.dart';
import 'package:dex/base.dart';
import 'package:dex/newOrder.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:dex/dataStructures.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

class DeliveryDetails extends StatefulWidget {
  final OrderPackage form;
  const DeliveryDetails({Key key, this.form}) : super(key: key);

  _DeliveryDetails createState() => _DeliveryDetails();
}

class _DeliveryDetails extends State<DeliveryDetails> {
// TextField Controllers
  TextStyle _namefont = new TextStyle(fontFamily: "roboto", fontSize: 24);
  TextStyle _valuefont = new TextStyle(fontFamily: "roboto", fontSize: 15);

  List<String> _places = ['Serekunda', 'Banjul', 'Bakau', 'Brikama']; 

  var _delivery_address = 'null';
  var _delivery_note = 'null';
  var _recipient_contact = 'null';
  var _recipient_name = 'null';   
  var _deliveryNote = 'null';
  var deliveryLocation = 'Serekunda';
  var _deliveryAddress = 'null';
  String _deliveryDate = "Delivery Date";
  String _deliveryTime = "Delivery Time";

  var dateFormater = new DateFormat('dd-MM');

  _pickDate() async {
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().day),
      lastDate: DateTime(DateTime.now().day + 30),
      initialDate: DateTime(DateTime.now().day),
    );  
    if (date != null)
      setState(() {
        _deliveryDate = dateFormater.format(date);
      });
  }

  _pickTime() async {
    TimeOfDay t = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (t != null)
      setState(() {
        _deliveryTime = t.format(context);
      });
  }

  showSuccess(String str) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Success"),
            content: Text(str),
          );
        });
  }

  showError(String err) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Alert"),
            content: Text(err),
            actions: <Widget>[
              FlatButton(
                child: Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  _sendOrder() async {
    print("sending order");
    String url = Provider.of<AppState>(context, listen: false).serverUrl;
    String user_id = Provider.of<AppState>(context, listen: false).cred.user_id;
    var body = {
      "user_id": user_id,
      "package_size": widget.form.package_size,
      "pickup_address": widget.form.pickup_address,
      "pickup_date": widget.form.pickup_date,
      "pickup_time": widget.form.pickup_time,
      "delivery_note": _delivery_note,
      "_delivery_time": _deliveryTime,
      "_delivery_date": _deliveryDate,
      "_delivery_address": _deliveryAddress,
      "recipient_contact": _recipient_contact,
      "recipient_name": _recipient_name,
      "_pickupLocation":widget.form.pickupLocation,
      "_deliveryLocation":deliveryLocation
    };
// Optionally the request above could also be done as
    print("order almost sent");
    print("body $body");
    var response = await http
        .post("$url/market/sendOrder.php", body: body)
        .timeout(Duration(seconds: 10), onTimeout: () {
      showError("NetWork Error, Please Try Again");
    });
    print(" order sent ");

    switch (response.statusCode) {
      case 200:
        print('-------------------------');
        print(response.body);

        if(response.statusCode.toString().trim().contains("404")){
             showError("Server Error, please try again later. /n error code: ${response.statusCode}");
        } else {
          
           showSuccess("Order Was successfully placed");
        // Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
        //                return NewOrder(); //Going back to the new order start page
        // }));
        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(builder: (context) => Home()),
        //     ModalRoute.withName("/Home"));
        }
        break;
      default:
        print(response.statusCode);
        showError(
            "Server Error, please try again later. /n error code: ${response.statusCode}");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery Details"),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 70),
          ),
         
           Container(
              width: 200,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  color: Colors.black26, borderRadius: BorderRadius.circular(10)),
              // dropdown below..
              child: DropdownButton<String>(
                  value: deliveryLocation,
                  hint: Text("Pickup Location"),
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 42,
                  underline: SizedBox(),
                  onChanged: (String newValue) {
                    setState(() {
                      deliveryLocation = newValue;
                    });
                    print("dropdown value: $deliveryLocation");
                  },
                  items: _places.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList()),
            ),
         
         
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          TextField(
            onChanged: (text) {
              _delivery_address = text;
            },
            style: TextStyle(fontSize: 20),
            autofocus: false,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: "Delivery Address",
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
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: FlatButton(
                    onPressed: _pickDate,
                    child: Container(
                        width: 100,
                        height: 50,
                        color: Colors.amber,
                        child: Center(child: Text(_deliveryDate)))),
              ),
              // Expanded(flex:1,child: null),
              Expanded(
                flex: 5,
                child: FlatButton(
                    onPressed: _pickTime,
                    child: Container(
                        width: 100,
                        height: 50,
                        color: Colors.amber,
                        child: Center(child: Text(_deliveryTime)))),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          TextField(
            onChanged: (text) {
              _recipient_name = text;
            },
            style: TextStyle(fontSize: 20),
            autofocus: false,
            decoration: InputDecoration(
              hintText: "Recipient Name",
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
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          TextField(
            onChanged: (text) {
              _recipient_contact = text;
            },
            style: TextStyle(fontSize: 20),
            autofocus: false,
            decoration: InputDecoration(
              hintText: "Delivery Contact",
              border: new OutlineInputBorder(
                borderSide: new BorderSide(
                  color: Colors.teal,
                ),
              ),
              prefixIcon: const Icon(
                Icons.phone,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          TextField(
            onChanged: (text) {
              _delivery_note = text;
            },
            style: TextStyle(fontSize: 20),
            autofocus: false,
            decoration: InputDecoration(
              hintText: "Delivery Note",
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
                child: FlatButton(
                    onPressed: () {
                      _sendOrder();
                    },
                    child: Container(
                        width: 100,
                        height: 50,
                        color: Colors.amber,
                        child: Center(child: Text("Next")))),
              )
            ],
          ),
        ],
      ),
    );
  }
}
