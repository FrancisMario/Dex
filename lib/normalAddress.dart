import 'package:dex/appState.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';


class NormalAddress extends StatefulWidget {
  NormalAddress({Key key}) : super(key: key);

  @override
  _NormalAddressState createState() => _NormalAddressState();

  var body;
}

class _NormalAddressState extends State<NormalAddress> {
    final _addressDescriptionController = TextEditingController();
    final _addressLocationController = TextEditingController();
      // phone textbox box controller
    final _addressNameController = TextEditingController();

    showMessage(String massage) async {
      await  showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Alert"),
            content: Text(massage),
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

    isCharacter(String a){
        List b = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'];
        List c = ['1','2','3','4','5','6','7','8','9','0','-','=','"',"'",'<','>','/','\\',' ',':',';','!','@','#','\$','%','^','&','*','(',')','_','+','.',',','[',']','{','}'];

        if (b.contains(a.toLowerCase().trim()) || c.contains(a)) {
            return true; 
        }

        return false;
  }

  prepString(String a){
      
      var b = a.split('');
      var c = '';
      for (var item in b) {
        if (isCharacter(item)) {
          c += item;
          print("++++ => $item");
        } else {
          c += '`';
          print("--- $item => `");
        }
      }
      return c;
  }

    _saveNormalAddress(String name, String description, String location) async {
    String url = Provider.of<AppState>(context, listen: false).serverUrl;
    String user_id = Provider.of<AppState>(context, listen: false).cred.user_id;
    widget.body = {
      "user_id": user_id,
      "name": name,
      "description": description,
      "coordinates": location,
      "type": "normal"
    };
    var response = await http.post("$url/market/addAddress.php", body: widget.body
    ).timeout(Duration(seconds: 10), onTimeout: () {
      print("timeout reached");
    }).catchError((onError) {
      print("onError");
      print(onError);
    });

    switch (response.statusCode) {
      case 200:
        print("200");
        print(response.body);

        if(response.body == "404"){
          await showMessage("Error, please try again.");
        return false;
        } else {
        await showMessage("Address was Successfully Added.");
        return true;
        }
        // Navigator.of(context).pop();
        // widget.items.add(_addressCard({
        //   "user_id": user_id,
        //   "name": name,
        //   "description": description,
        //   "coordinates": location,
        //   "type": "normal"
        // }));
        break;
      default:
        await showMessage("Sorry, there was an error.");
        print("Error");
        print(response.statusCode);
        return false;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       child: Scaffold(
      appBar: AppBar(title: Text("Normal Address")),
      body: Container(
        margin: EdgeInsets.all(20),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width - 10,
              child: Text(
                "Normal Addresses are alot less acurate than smart address. They require a detailed description of the location.",
                overflow: TextOverflow.clip,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 10),
            new TextFormField(
              maxLength: 10,
              controller: _addressNameController,
              decoration: new InputDecoration(
                labelText: "Give this address a name.",
                fillColor: Color.fromRGBO(62, 62, 62, 1),
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                  borderSide: new BorderSide(),
                ),
              ),
              validator: (val) {
                if (val.isEmpty) {
                  return "phone cannot be empty";
                } else {
                  return null;
                }
              },
              keyboardType: TextInputType.text,
              style: new TextStyle(
                fontFamily: "Poppins",
              ),
            ),
            SizedBox(height: 10),
            new TextFormField(
              maxLines: 3,
              controller: _addressDescriptionController,
              decoration: new InputDecoration(
                labelText: "Add some descriptions will ya?",
                fillColor: Color.fromRGBO(62, 62, 62, 1),
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                  borderSide: new BorderSide(),
                ),
              ),
              validator: (val) {
                if (val.isEmpty) {
                  return "phone cannot be empty";
                } else {
                  return null;
                }
              },
              keyboardType: TextInputType.multiline,
              style: new TextStyle(
                fontFamily: "Poppins",
              ),
            ),
            SizedBox(height: 10),
            new TextFormField(
              maxLines: 7,
              controller: _addressLocationController,
              decoration: new InputDecoration(
                // labelText: "Describe the Location.",
                hintText: "eg. West-Coast-Region Serekunda Bamboo",
                hintStyle: TextStyle(wordSpacing: 1000, fontSize: 20),
                fillColor: Color.fromRGBO(62, 62, 62, 1),
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                  borderSide: new BorderSide(),
                ),
              ),
              validator: (val) {
                if (val.isEmpty) {
                  return "this camnnot be empty";
                } else {
                  return null;
                }
              },
              keyboardType: TextInputType.multiline,
              style: new TextStyle(
                fontFamily: "Poppins",
              ),
            ),
            SizedBox(height: 10),
            FlatButton(
              color: Colors.green,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.blueAccent,
              onPressed: () async {
                if (_addressNameController.value.text != "" &&
                    _addressDescriptionController.value.text != "" &&
                    _addressLocationController.value.text != "") {

                      // setting up the address description
                      // String finalString = "";
                      // var ss = _addressLocationController.value.text;
                      // var ssJson = ss.split(" ");
                      // for (var item in ssJson) {
                      //   finalString += item.trim();
                      //   print("================");
                      //   print(item);
                      // }
                      var ss = _addressLocationController.value.text;
                      ss = prepString(ss);
                      print(ss);

                      // String finalString = ss.replaceAll(RegExp(' {2, }'),' ');
                if( await _saveNormalAddress(_addressNameController.value.text.trim(),_addressDescriptionController.value.text.trim(),ss.trim())){
                    Navigator.pop(context,widget.body);
                  }
                } else {
                  showMessage("You must fill all fields");
                } 
              },
              child: Container(
                width: 200,
                height: 50,
                child: Center(
                  child: Text(
                    "SAVE",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}