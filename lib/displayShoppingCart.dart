import 'package:dex/appState.dart';
import 'package:dex/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DisplayShoppingCart extends StatefulWidget {
  DisplayShoppingCart({Key key}) : super(key: key);

  @override
  _DisplayShoppingCartState createState() => _DisplayShoppingCartState();
}

class _DisplayShoppingCartState extends State<DisplayShoppingCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: Container(
      //               width:48,
      //               decoration: BoxDecoration(
      //                 color: Theme.of(context).primaryColor,
      //                 borderRadius: BorderRadius.circular(30)
      //               ),
      //               child: Text("Order"),
      //                 ),
       body: CustomScrollView(
                    physics: BouncingScrollPhysics(),
                    slivers:<Widget>[
                    SliverAppBar(
                        title:Text("Hello World"),
                        expandedHeight:100.0,
                        floating: false,
                        pinned: true,
                        flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                          title: Text("Title"),
                          background: Image.network("" //TODO
                          ,fit: BoxFit.cover,),
                          ),
                      ),

           new SliverList(
             key: widget.key,
             delegate: SliverChildListDelegate(_builder())),
         ],
       ),
    );
  }

  _builder(){
      List<Widget> list = [];
     var products = Provider.of<AppState>(context, listen: true).shoppingCart.readProduct();
print(products);
      if(true){
        list.add(Text("No Item where added to cart. try shopping a bit."));
        list.add(Text("No Item where added to cart. try shopping a bit."));
        list.add(Text("No Item where added to cart. try shopping a bit."));
      } else{
          for (var item in products) {
          list.add(ProductBox(item: item,key: widget.key,));
     }
      }
     return list;
  }
}





class ProductBox extends StatefulWidget {
  ProductBox({
    Key key,
    this.item
  }): super(key: key);

  final Product item;

  @override
  _ProductBoxState createState() => _ProductBoxState();
}

class _ProductBoxState extends State<ProductBox> {

  var total = 0;

  void getTotal(){
    setState(() {
      total = widget.item.getTotal();
    });
  }
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      height: 140,
      child: Card( 
        child: Row( 
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget> [ 
            // Image.asset("assets/appimages/" + this.item.image),
            Expanded( child: 
              Container( padding: EdgeInsets.all(5), 
                    child: Column( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: < Widget > [ 
                                      Text(
                                        this.widget.item.product_name,
                                        style: TextStyle( 
                                          fontWeight: FontWeight.bold 
                                              )
                                          ), 
                                        Text(
                                          this.widget.item.product_description
                                             ), 
                                        Text("Price: " + this.widget.item.price.toString()), 
                                        // RatingBox(),
                                         ], 
                                         )
                                        )
                                       )
                                     ]
                                   ),
                                 )
                                );
  }
}
