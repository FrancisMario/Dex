import 'package:dex/appState.dart';
import 'package:dex/product.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckOut extends StatefulWidget {
  final List<String> cart;
  final String ent_id;
  CheckOut({Key key, this.cart, this.ent_id}) : super(key: key);

  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  List<Product> products = [];

  Future checkOut(){

  }
  
   Future checkCart() async {

     if(!(widget.cart.length < 0)){
       
     } else {
       // if nothing is in cart
       return null;
     }
    // var cart = Provider.of<AppState>(context, listen: true).cartProducts;
    // if(cart == null){
    //    products.add( Product.fromJson({"user_id":"user_id","product_description":"product_description","category_id":"category_id","ectity_id":"ectity_id","product_id":"product_id","price":20,"image_0":"image_0"}));
    //   return false;
    // } else {
    //   this.products = cart;
    //   return true;
    // }
  }

  Widget total(){
    if(products == null){
      return Text("");
    }
     return  Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: 
                GestureDetector(
                    child: Container(
                    height: MediaQuery.of(context).size.width / 6,
                    color: Colors.redAccent,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:<Widget>[
                            Expanded(
                              child: Center(
                                child: Column(
                                  children:<Widget>[
                                    Text("200",style:TextStyle(fontSize: 30,color: Colors.white)),
                                    Text("product",style:TextStyle(fontSize: 10,color: Colors.white))
                                  ]
                                ),
                              )
                            ),
                            Expanded(
                              child: Column(
                                children:<Widget>[
                                  Text("200",style:TextStyle(fontSize: 30,color: Colors.white)),
                                  Text("delivery",style:TextStyle(fontSize: 10,color: Colors.white))
                                ]
                              )
                            ),
                            Expanded(
                              child: Column(
                                children:<Widget>[
                                  Text("400",style:TextStyle(fontSize: 30,color: Colors.white)),
                                  Text("total",style:TextStyle(fontSize: 10,color: Colors.white))
                                ]
                              )
                            ),
                          ]
                        ),
                    ),    
                  ),
                ),
              );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text("Check Out")),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            verticalDirection: VerticalDirection.up,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: 
                GestureDetector(
                    child: Container(
                    height: MediaQuery.of(context).size.width / 6,
                    color: Colors.redAccent,
                    child: Center(child: Text("Check out",style:TextStyle(fontSize: 30,color: Colors.white))),    
                  ),
                ),
              ),
              
         



               Container(
                  child: FutureBuilder(
                      future: checkCart(),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          ///when the future is null
                          case ConnectionState.none:
                            return Text(
                              'Press the button to fetch data',
                              textAlign: TextAlign.center,
                            );

                          case ConnectionState.active:

                          ///when data is being fetched
                          case ConnectionState.waiting:
                            return CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.blue));

                          case ConnectionState.done:
                            ///task is complete with an error (eg. When you
                            ///are offline)
                            if (snapshot.hasError) {
                              print("snapshot has error");
                              print(snapshot.error);
                              return Center(
                                child: Container(
                                  child: Text("Snapshot has error"),
                                ),
                              );
                            }
                            print(snapshot.data);
                            if(snapshot.data){
                             return ListView.builder(
                               itemCount: products.length,
                               itemBuilder: (context, index){
                                 print(products[index].category_id);
                                return Text(products[index].category_id);
                               }
                              );
                              } else {
                                return Center(
                                  child: Container(
                                    height: MediaQuery.of(context).size.height / 2,
                                    child: Text("No Product in cart"),
                                  ),
                                );
                              }
                            
                        }
                      })),

            ],
          ),
        ),
      ),
    );
  }
}

