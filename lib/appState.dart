import 'dart:collection';

import 'package:dex/dataStructures.dart';
import 'package:dex/product.dart';
import 'package:dex/database.dart';
import 'package:dex/virtualShoppingCart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 * this class saves and update the state of the whole app
 */

class AppState with ChangeNotifier{
      

    // custom delivery cart
      Address customDeliverSmartAddress = null;
      String customDeliverDumbAddress = null;

    // Cart stuff
      Address cartAddress = null;
      List<String> cart  = null;
      // List<Product> cartProducts = [];
      


      DatabaseHandler dbhdl = new DatabaseHandler();

      String serverUrl = "https://api.v1.odudostudios.com/";

      Stat stat = null;
      Stat get _stat => stat;
      Map session = {};


      OrderPackage order = new OrderPackage();
      OrderPackage get _order => order;

      VirtualShoppingCart shoppingCart = new VirtualShoppingCart();
      VirtualShoppingCart get _shoppingCart => shoppingCart;

      
      Credential cred = null;
      Credential get _cred => cred;

      RecordList orderList = null;
      RecordList get _orderList => orderList;
      
      void setCred(Credential newCred,bool save){
          this.cred = newCred;
          if (save) {
            print(newCred.name);
            print(newCred.phone);
            print(newCred.user_id);
          dbhdl.InsertCredential(newCred);
          }
          notifyListeners();
      }

      void setStat(newStat){
          this.stat = newStat;
          notifyListeners();
      }

       void setOrderList(newlist){
          this.orderList= newlist;
          notifyListeners();
      }

}