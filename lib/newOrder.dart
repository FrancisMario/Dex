import 'package:dex/appState.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:provider/provider.dart';


class NewOrder extends StatefulWidget {
  _NewOrder createState()=>_NewOrder();
}

class _NewOrder extends State<NewOrder> {

// Values
  String name = '';
  String phone = '';
  String delivery_address = '';
  Future<TimeOfDay> delivery_time;
  Future<DateTime> delivery_date;
  Future<DateTime> pickup_date;
  Future<TimeOfDay> pickup_time;
  String sender_id = '';
  String order_date = '';
  String order_time = '';
  String order_details = '';
  String package_description = '';
  String package_size;
  String delivery_note = '';

  String delivery_date_display = 'Date';
  String delivery_time_display = 'Time';

// TextField Controllers
  TextStyle _namefont  =  new TextStyle(fontFamily: "roboto",fontSize:24);
  TextStyle _valuefont  =  new TextStyle(fontFamily: "roboto",fontSize:15);
  TextEditingController _name_controller;
  TextEditingController _phone_controller;
  TextEditingController _address_controller;
  TextEditingController _delivery_date;
  TextEditingController _delivery_time;
  TextEditingController _pickup_date;
  TextEditingController _pickup_time;
  TextEditingController _package_description;
  TextEditingController _delivery_note;

  List<Widget> screens = [];

    final snackBar = SnackBar(
            content: Text('Please Complete the form!'),
            action: SnackBarAction(
              label: 'close',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );

    void _submitForm(){
        print("submit order clicked");
    }


    

  @override 
  Widget build(BuildContext context) {

    // Package Details Widget
  //  Widget packageDetails = null ;
  
    // Delivery Details Widget
  //  Widget deliveryDetails = new Container(
  //    width: 400,
  //   child:  Container(
  //       height: 300,
  //       color: Colors.amberAccent,
  //       child: Center(
  //     child: Column(
  //       key: widget.key,
  //       children:<Widget>[
  //         // Title Text
  //             Text("DELIVERY DETAILS"),
  //             Padding(padding: EdgeInsets.only(bottom:30)),
  //             // divider line 
  //             // Container(width: 50,height: 1,child: Divider(),),
  //             // pickup date and time Picker  
  //             Row(
  //                 children: <Widget>[
  //                   Expanded(
  //                       child: Container(
  //                        padding: EdgeInsets.all(10),
  //                         height: 50,
  //                         decoration: BoxDecoration(
  //                                 border: Border.all(
  //                                   color: Colors.black,),
  //                           ),
  //                         child: Row(children:<Widget>[
  //                         Expanded(child: Text(delivery_date_display)),
  //                         Expanded(child: GestureDetector(child: Icon(Icons.calendar_today),onTap: (){
  //                           print("DAte picker tapped");
  //                               showDatePicker(
  //                                 context: context,
  //                                 initialDate: DateTime.now(),
  //                                 firstDate: DateTime(DateTime.now().year),
  //                                 lastDate: DateTime(DateTime.now().year+1),
  //                               ).then((date){
  //                                 setState(() {
  //                                     delivery_date_display = date.toString();
  //                                 });
  //                               }); 
                                
  //                           },),),
  //                         ],
  //                       ),
  //                       ),
  //                   ),
  //                    Expanded(
  //                      child: Container(
  //                        padding: EdgeInsets.all(10),
  //                         height: 50,
  //                         decoration: BoxDecoration(
  //                                 border: Border.all(
  //                                   color: Colors.black,),
  //                           ),
  //                         child: Row(children:<Widget>[
  //                         Expanded(child: Text(delivery_time_display)),
  //                         Expanded(child: GestureDetector(child: Icon(Icons.access_time),onTap: (){
				                              
  //                                      showTimePicker(
  //                                             initialTime: TimeOfDay.now(),
  //                                             context: context,
  //                                         ).then((time){
  //                                         setState(() {
  //                                           delivery_time_display = time.format(context);
  //                                         });
  //                                         });
                            
                           
                                  
  //                         },)),
  //                       ]),),
  //                   )
  //                 ],
  //             ),
  //             Padding(padding: EdgeInsets.only(bottom:4)), 
  //            Container(width: 50,height: 1,child: Divider(),),
  //             // Address Section
  //             Row(
  //               children: <Widget>[
  //                 Center(
  //                   child: Container(
  //                     height: 150,
  //                     width: 300,
  //                       margin: EdgeInsets.all(12),
  //                       // height: 5 * 24.0,
  //                       child: TextField(
  //                         controller: _delivery_note,
  //                         cursorWidth: 150,
  //                             maxLines: 5,
  //                             decoration: InputDecoration(
  //                                       hintText: "Enter an address to deliver to",
  //                                       fillColor: Colors.grey[300],
  //                                       filled: true,
  //                               ),
  //                       onChanged: (value){
  //                           delivery_note = value;
  //                       },
  //                       onSubmitted: (value){
  //                           delivery_address = value;
  //                       },
  //                       ),
  //                    ),
  //                 )
  //               ],
  //             ),
  //           ],
  //         ),
  //   ),
 
  // ),);
    


  // screens.add(packageDetails);
  // screens.add(deliveryDetails);

    return Scaffold(
      appBar: AppBar(),
      body: new Container(
          height: 500,
          width: 400,
          child: Column(
              children:<Widget>[
        // Title Text
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
            Padding(padding: EdgeInsets.only(top:5)),
            Text("PACKAGE DETAILS"),
            Padding(padding: EdgeInsets.only(bottom:4)),
            // divider line 
            // Container(width: 50,child: Divider(),), 
            // pickup date and time Picker  
            Row(
                children: <Widget>[
                  Expanded(
                      child:
                      Container(
                         padding: EdgeInsets.all(10),
                          height: 50,
                          width: 200,
                          decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,),
                            ),
                          child:
                            Row(
                              children:<Widget>[
                                Expanded(child: Text(delivery_date_display)),
                                Expanded(child: GestureDetector(child: Icon(Icons.calendar_today),onTap: (){
                                      print("Date picker tapped");
                                      showDatePicker(
                                        context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(DateTime.now().year),
                                  lastDate: DateTime(DateTime.now().year+1),
                                ).then((date){
                                  setState(() {
                                      delivery_date_display = date.toString();
                                  });
                                }); 
                                
                            },),),
                          ],
                        ),
                        ),
                  ),


                   Expanded(
                      child: 
                      Container(
                         padding: EdgeInsets.all(10),
                          height: 50,
                          decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,),
                            ),
                          child: Row(children:<Widget>[
                          Expanded(child: Text(delivery_date_display)),
                          Expanded(child: GestureDetector(child: Icon(Icons.calendar_today),onTap: (){
                            print("Time picker tapped");
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(DateTime.now().year),
                                  lastDate: DateTime(DateTime.now().year+1),
                                ).then((date){
                                  setState(() {
                                      delivery_date_display = date.toString();
                                  });
                                }); 
                                
                            },),),
                          ],
                        ),
                        ),
                  ),
                ],
            ),
            Padding(padding: EdgeInsets.only(bottom:4)),
            
            // package size settings
            Row(
              children: <Widget>[ 
                   DropDownFormField(
                        titleText: 'Package Size',
                        hintText: 'select a size',
                        value: pickup_date,
                        dataSource: [
                            {
                              "display": "file",
                              "value": "file",
                            },
                            {
                              "display": "Small",
                              "value": "small",
                            },
                             {
                              "display": "large",
                              "value": "large",
                            },
                             {
                              "display": "exLarge",
                              "value": "exLarge",
                            }
                         ],
                         textField: 'display',
                         valueField: 'value',
                         onSaved: (value){
                            setState(() {
                              package_size = value;
                            });
                         },
                         onChanged: (value){
                           setState(() {
                              package_size = value;
                           });
                         },
                ),
              ],
            ),  
            //  Container(width: 50,child: Divider(),),
            // Package Description



            Row(
              children: <Widget>[
                Container(
                  width: 100,
                    margin: EdgeInsets.all(12),
                    height: 5 * 24.0,
                    child: TextField(
                      controller: _delivery_note,
                          maxLines: 5,
                          decoration: InputDecoration(
                                    hintText: "Enter a delivery note",
                                    fillColor: Colors.grey[300],
                                    filled: true,
                            ),
                    onChanged: (value){
                        delivery_note = value;
                    },
                    onSubmitted: (value){
                        delivery_note = value;
                    },
                    ),
                 )
              ],
            ),
          ],
        ),
      ],
    ),
  ),  
    );
  }


}



