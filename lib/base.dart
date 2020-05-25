import 'package:dex/dash.dart';
import 'package:dex/orders.dart';
import 'package:dex/settings.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
   Home({Key key}) : super(key: key);
   @override
  _Home createState() => _Home();
}
class _Home extends State<Home>{

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
   List<Widget> _widgetOptions = <Widget>
   [
    Dash(),
    Orders(),
    // Settings(),
   ];

  void _onItemTapped(int index) {
    setState(() {
      print(index.toString() + 'pressed');
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child:_widgetOptions.elementAt(_selectedIndex),
        ),


      bottomNavigationBar:  
        BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment,color: Colors.black,),
            title: Text('Dashboard',style: TextStyle(color:Colors.black),),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart,color: Colors.black),
            title: Text('Delivery',style: TextStyle(color:Colors.black),),
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.settings,color: Colors.black),
          //   title: Text('Settings',style: TextStyle(color:Colors.black),),
          // ),
        ],
         currentIndex: _selectedIndex,
         selectedItemColor: Colors.red[800],
         onTap: _onItemTapped,
        )
    ); 
  }
}
