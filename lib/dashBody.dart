import 'package:dex/appState.dart';
import 'package:dex/selectPlan.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashBody extends StatefulWidget {
    @override
  _DashBody createState() => _DashBody(); 
}

  class _DashBody extends State<DashBody> {

    // svg Image assets  
    final Widget subcription = SvgPicture.asset(
        "assets/subscription.svg",
        semanticsLabel: 'Acme Logo',
        
    );
    final Widget clock = SvgPicture.asset(
        "assets/clock.svg",
        semanticsLabel: 'Acme Logo',
    );
    final Widget user = SvgPicture.asset(
        "assets/user.svg",
        semanticsLabel: 'Acme Logo',
    );
    final Widget dish = SvgPicture.asset(
        "assets/dish.svg",
        semanticsLabel: 'Acme Logo',
    );
    
    // TExt Styling
   TextStyle _title  =  new TextStyle( fontFamily: "Roboto",fontSize:30,fontWeight: FontWeight.bold,color: Colors.white);
   TextStyle _normal  =  new TextStyle(fontFamily: "Roboto",fontSize:18,color: Colors.white);
   TextStyle _normalBig  =  new TextStyle(fontFamily: "Roboto",fontSize:19,color: Colors.white);
   TextStyle _extraSmall  =  new TextStyle(fontFamily: "Roboto",fontSize:9,color: Colors.white);
   TextStyle _valuefont2 =  new TextStyle(fontFamily: "Roboto",fontSize:15,color: Colors.white);

  @override
  Widget build(BuildContext context) {
    String name =  Provider.of<AppState>(context, listen: true).cred.name;
    return 
     ListView(
         children:<Widget>[
     Container(
      child: Center(
        child: Column(
          children:<Widget>[             
              Container(
                 width: 300,
                 child:  
                Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children:<Widget>[
                  Padding(padding: EdgeInsets.only(top:30)),
                  Padding(padding: EdgeInsets.all(5)),
                  Text("Welcome Back",style: _normal,),
                  Padding(padding: EdgeInsets.only(top:2)),
                  Text( name ,style: _title,),
                      Divider(
                            thickness: 1,
                            color: Colors.black,
                            ),
                ]
              ),
              ),
       
            Column(
             children:<Widget> [ 
                Column(
                  children:<Widget>[
             Padding(padding: EdgeInsets.only(top:5)),
             Container(
               decoration: BoxDecoration(
                 borderRadius:new  BorderRadius.circular(2.0),
                 color: Colors.blueAccent,
                   boxShadow: [
                         BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10.0, // has the effect of softening the shadow
                              spreadRadius: 5.0, // has the effect of extending the shadow
                             offset: Offset(
                                10.0, // horizontal, move right 10
                               10.0, // vertical, move down 10
                              ),
                            )
                          ],
                      ),
               width: 300,
               height: 130,
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top:10)),
                    Container(
                      margin: EdgeInsets.only(left:8),
                      child: 
                      Text("Daily Time",style: _normalBig),
                    ),
                    Padding(padding: EdgeInsets.only(top:30)),
                    Center(
                      child:GestureDetector(
                       onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){return SelectPlan("Change Plan");}));
                       },
                       child:Container(
                         decoration: BoxDecoration(
                              border: Border.all(color: Colors.purple),
                              borderRadius:new  BorderRadius.circular(2.0),
                              color: Colors.pinkAccent,
                              boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 10.0, // has the effect of softening the shadow
                                      spreadRadius: 5.0, // has the effect of extending the shadow
                                      offset: Offset(
                                              10.0, // horizontal, move right 10
                                              10.0, // vertical, move down 10
                              ),
                            )
                          ],
                      ),
                         width: 200,
                         height: 40,
                         child: Center(
                           child:
                           Text("Change Plan",style: _normalBig,
                           )
                          ),
                      ),
                      ),
                    ),
                  ],
               ),
             ),


            Padding(padding: EdgeInsets.only(top:20)),
            Text("Other Services",style: _normal,),

            Padding(padding: EdgeInsets.only(top:5)),
              Container(
              decoration: BoxDecoration(
                 borderRadius:new  BorderRadius.circular(2.0),
                 color: Colors.blueAccent,
                   boxShadow: [
                         BoxShadow(
                              color: Colors.blueGrey,
                              blurRadius: 10.0, // has the effect of softening the shadow
                              spreadRadius: 5.0, // has the effect of extending the shadow
                             offset: Offset(
                                5.0, // horizontal, move right 10
                               5.0, // vertical, move down 10
                              ),
                            )
                          ],
                      ),
               width: 310,
               height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:<Widget>[
                  Expanded(flex:3,child: Center(child:Image.asset('assets/dish.png',height: 50,width: 50,),)),
                  Expanded(flex:7,child: Container(
                    child:Center(
                    child: Column(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(top:15)),
                          Text("Cash Deposits",style: _title,),
                      ],
                     ),
                    ),
                   ),
                  ),
                ]
                ),
            ),


            Padding(padding: EdgeInsets.only(top:10)),
            Container(
              decoration: BoxDecoration(
                 borderRadius:new  BorderRadius.circular(2.0),
                 color: Colors.blueAccent,
                   boxShadow: [
                         BoxShadow(
                              color: Colors.blueGrey,
                              blurRadius: 10.0, // has the effect of softening the shadow
                              spreadRadius: 5.0, // has the effect of extending the shadow
                             offset: Offset(
                                5.0, // horizontal, move right 10
                               5.0, // vertical, move down 10
                              ),
                            )
                          ],
                      ),
               width: 310,
               height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:<Widget>[
                 Expanded(flex:3,child: Center(child:Image.asset('assets/dish.png',height: 50,width: 50,),)),
                  Expanded(flex:7,child: Container(
                    child:Center(
                    child: Column(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(top:15)),
                          Text("Food Deliveries",style: _title,),
                      ],
                     ),
                    ),
                   ),
                  ),
                ]
                ),
            ),
            
             Padding(padding: EdgeInsets.only(top:10)),
            Container(
              decoration: BoxDecoration(
                 borderRadius:new  BorderRadius.circular(2.0),
                 color: Colors.blueAccent,
                   boxShadow: [
                         BoxShadow(
                              color: Colors.blueGrey,
                              blurRadius: 10.0, // has the effect of softening the shadow
                              spreadRadius: 5.0, // has the effect of extending the shadow
                             offset: Offset(
                                5.0, // horizontal, move right 10
                               5.0, // vertical, move down 10
                              ),
                            )
                          ],
                      ),
               width: 310,
               height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:<Widget>[
                  Expanded(flex:3,child: Center(child:Image.asset('assets/subscription.png',height: 50,width: 50,),)),
                  Expanded(flex:7,child: Container(
                    child:Center(
                    child: Column(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(top:15)),
                          Text("One Of Delivery",style: _title,),
                      ],
                     ),
                    ),
                   ),
                  ),
                ]
                ),
            ),
        Padding(padding: EdgeInsets.only(bottom:10)),
                ],
              ),
            ],
          ),
       ]
      ),
      ),
     ),
     ]
   );
  }
}
