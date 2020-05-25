import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailedEntityView extends StatefulWidget {
  DetailedEntityView({Key key}) : super(key: key);

  @override
  _DetailedEntityViewState createState() => _DetailedEntityViewState();

   
  var menu = [
    {"name":"Noodles","id":"1234","price":200,"picture":"assets/food.JPG"},
    {"name":"Noodles","id":"1234","price":200,"picture":"assets/food.JPG"},
    {"name":"Noodles","id":"1234","price":200,"picture":"assets/food.JPG"},
    {"name":"Noodles","id":"1234","price":200,"picture":"assets/food.JPG"},
    {"name":"Noodles","id":"1234","price":200,"picture":"assets/food.JPG"}
  ];
}

class _DetailedEntityViewState extends State<DetailedEntityView> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Scaffold(
         floatingActionButton:
                Container(
                          // margin: EdgeInsets.only(right:10),
                    width:48,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(30)
                          ),
                    child: IconButton(
                              icon: Icon(Icons.shopping_cart), 
                              color: Colors.white,
                              onPressed: () {
                            
                                  print("dd");
                                  }),
                      ),
          body: Column(
            children:<Widget>[
                Stack(
                  children: <Widget>[ 
                    Image(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        image: AssetImage('assets/food.JPG'),
                        fit: BoxFit.cover,
                        ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 20.0),
                      child: Row(
                          children: <Widget>[
                            IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,),iconSize: 30.0),
                            IconButton(icon: Icon(Icons.shopping_basket,color: Colors.pink,semanticLabel:"ds"),iconSize: 30.0,),
                           ],
                      ),
                    ),
                  ],
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 1,horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                        SizedBox(height: 5,),
                        Text("McCeaser's",style: TextStyle(fontSize:30,fontWeight: FontWeight.bold),),
                        SizedBox(height: 10,),
                        Row(
                          children: <Widget>[
                            Icon(Icons.star,color: Colors.yellow,),
                            Icon(Icons.star,color: Colors.yellow),
                            Icon(Icons.star, color: Colors.yellow),
                            Icon(Icons.star_half, color: Colors.yellow)
                          ],
                        ),
                        SizedBox(height: 5,),
                        Text("Westfield",style: TextStyle(fontSize:20),),
                        SizedBox(height: 10,),
                        SizedBox(height: 10,width: MediaQuery.of(context).size.width / 1.3, child: Divider(thickness: 1.5,),),
                        SizedBox(height: 3,),
                         Text("Menu",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),),
                        // Text("CREATE TABLE `market_tables`.`#entity_ID#` ( `table_id` INT NOT NULL AUTO_INCREMENT , `entity_id` VARCHAR(10) NOT NULL , `entity_name` VARCHAR(20) NOT NULL , `entity_description` TEXT NOT NULL , `entity_image` VARCHAR(100) NOT NULL, `visible` VARCHAR(20) NULL , PRIMARY KEY (`table_id`)) ENGINE = InnoDB",overflow: TextOverflow.clip,),
                  ],
                ),
              ),
            
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                physics: BouncingScrollPhysics(),
                children:
                  List.generate(
                    widget.menu.length, 
                    (index) {
                      return _builder();
                    } )
                ),
            ),
            ],
          ),
       ),
    );
  }

   Widget _builder(){
         return  GestureDetector(
              onTap: () {
                 
              },
              child: 
              Container(
                margin: EdgeInsets.all(10),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      height: 175.0,
                      width: 175.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:AssetImage('assets/food.JPG'),
                          fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    GestureDetector(
                      onLongPress: (){
                        showDetails();
                      },
                        child: Container(
                        height: 175.0,
                        width: 175.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.3),
                              Colors.black87.withOpacity(0.3),
                              Colors.black54.withOpacity(0.3),
                              Colors.black38.withOpacity(0.3),
                            ],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 60.0,
                      child: Column(
                        children: <Widget>[
                          Text("Noodles",style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.2
                          ),),
                          Text("D 150",style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.2
                          ),),
                      ],),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child:  Container(
                          // margin: EdgeInsets.only(right:10),
                          width:48,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(30)
                          ),
                          child: IconButton(
                                  icon: Icon(Icons.add), 
                                  color: Colors.white,
                                  onPressed: () {
                                      print("dd");
                                  }),
                      )
                    ),
                    
                  ],
                )
              ),
            );
  }

 showDetails(){
     showDialog(
    context: context,
    builder: (BuildContext context){
        return AlertDialog(
          scrollable: true,
          title: Text("Details"),
          content:  Container(
            height: 150,
            child: Column(
                        children: <Widget>[
                          Expanded(
                            child:
                            Text("Mario Gomez"),
                          ),
                          Expanded(
                              child: Text("sd dsan asidasnda sdiasdoind asdinaiod asidnasodi adiasndoias daiodnasiod asdasnoldias dadniaionda sdkjsadiasdla sdoujasoduiaosidnja sdsoandipasndasjo doasdionasdoas dasdnoiasdnasdla dasdoasn",
                              style: TextStyle(
                              ),overflow: TextOverflow.clip,),
                              ),
                  
                        ],
                      ),
          ) ,
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
}