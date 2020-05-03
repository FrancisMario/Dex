import 'package:dex/dataStructures.dart';
import 'package:dex/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 * this class saves and update the state of the whole app
 */

class AppState with ChangeNotifier{
      
      DatabaseHandler dbhdl = new DatabaseHandler();

      Stat stat = null;
      Stat get _stat => stat;
    
      Credential cred = null;
      Credential get _cred => cred;

      RecordList orderList = null;
      RecordList get _orderList => orderList;
      
      void setCred(newCred){
          this.cred = newCred;
          dbhdl.InsertCredential(newCred);
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