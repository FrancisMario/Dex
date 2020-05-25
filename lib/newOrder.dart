import 'package:dex/appState.dart';
import 'package:dex/dataStructures.dart';
import 'package:dex/deliveryDetails.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class NewOrder extends StatefulWidget {
  _NewOrder createState()=>_NewOrder();
}

class _NewOrder extends State<NewOrder> {

// TextField Controllers
  TextStyle _namefont  =  new TextStyle(fontFamily: "roboto",fontSize:24);
  TextStyle _valuefont  =  new TextStyle(fontFamily: "roboto",fontSize:15);

 


  List<String> _sizes = ['Extra Large', 'Large', 'Small', 'File']; 
  String _dropDownValue = null;
  String _pickupAddress = null;
  String _pickupDate = "Delivery Date";
  String _pickupTime = "Delivery Time";

  var  dateFormater =  new DateFormat('dd-MM');

    void _submitForm(){
        print("submit order clicked");
    }

    
   _pickDate() async {
   DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().day),
      lastDate: DateTime(DateTime.now().day+30),
      initialDate: DateTime(DateTime.now().day),
    );
    if(date != null)
      setState(() {
        _pickupDate = dateFormater.format(date);
      });
  }

 _pickTime() async {
   TimeOfDay t = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if(t != null)
      setState(() {
        _pickupTime = t.format(context);
      });
  }

  showError(){
    showDialog(
    context: context,
    builder: (BuildContext context){
        return AlertDialog(
          title: Text("Alert"),
          content: Text("You must complete the form"),
        );
    }
  );
  }
     var pickupAddress = null;
  
 


  @override 
  Widget build(BuildContext context) {
     TextEditingController _address_controller;

     bool _next(){

    if(_dropDownValue == null || pickupAddress == null || _pickupDate == "Delivery Date" || _pickupTime == "Delivery Time"){
    
      print(_dropDownValue);
      print(pickupAddress);
      print(_pickupDate);
      print(_pickupTime);
      showError();
    } else {
      OrderPackage form = new OrderPackage(); 
      form.package_size = _dropDownValue;
      form.pickup_address = pickupAddress;
      form.pickup_date =  _pickupDate;
      form.pickup_time = _pickupTime;
       Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){return DeliveryDetails(form:form);}));
    }

  }

    
  return Scaffold(
  appBar: AppBar(title: Text("Package Details"),),
  body: Column(
    children: <Widget>[
        Padding(padding: EdgeInsets.only(top:50),),
     Center(
       child: Container(
         width: 250, 
          child:
           Column(
              children:<Widget>[
                Padding(padding: EdgeInsets.only(top:30),),


                  Container(
    width: 200,
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
              
              color: Colors.black26,
              borderRadius: BorderRadius.circular(10)),
  // dropdown below..
    child: DropdownButton<String>(
        value: _dropDownValue,
        hint: Text("Package Size"),
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 42,
        underline: SizedBox(),
        onChanged: (String newValue) {
            setState(() {
              _dropDownValue = newValue;
            });
            print("dropdown value: $_dropDownValue");
        },
      items: _sizes.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList()),
  ),
        Padding(padding: EdgeInsets.only(top:10),),
                
                TextField(
                  onChanged: (text) {
                    pickupAddress = text;
                        print("new pickup address: $pickupAddress");
                        print("First text field: $text");
                     },
                  autofocus: false,
                   style: TextStyle(fontSize: 20),
                   maxLines: 3,
                   controller: _address_controller,
                   decoration: InputDecoration(
                      hintText: "Pickup Address",
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(
                              color: Colors.teal,
                            ),
                          ),
                      prefixIcon: const Icon(
                            Icons.location_on,
                            color: Colors.black12,
                          ),
                  ),
                ),

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
                    child: Center(child: Text(_pickupDate))
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
                    child: Center(child: Text(_pickupTime))
                  )
          ),
    )
  ],
),


                  Padding(padding: EdgeInsets.only(top:10),),

                



  Row(
    children: <Widget>[
    Expanded(
        flex: 5,
        child:
          FlatButton(
            onPressed: null, 
            child: Container(
                    width: 100,
                    height: 50,
                    color: Colors.amber,
                    child: Center(child: Text("Previous"))
                  )
          ),
       ),
            // Expanded(flex:1,child: null),
    Expanded(
        flex: 5,
        child:
          FlatButton(
            onPressed: (){
              print("next");
              _next();
            }, 
            child: Container(
                    width: 100,
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



