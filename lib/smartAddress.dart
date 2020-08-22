import 'package:dex/appState.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
// import 'package:geolocator/geolocator.dart' as locator;
import 'package:http/http.dart' as http;

class SmartAddress extends StatefulWidget {
  SmartAddress({Key key}) : super(key: key);

  @override
  _SmartAddressState createState() => _SmartAddressState();
}

class _SmartAddressState extends State<SmartAddress> {
  final _addressNameController = TextEditingController();
  final _addressDescriptionController = TextEditingController();

  _saveSmartAddress(String name, String description, LocationData data) async {
    String url = Provider.of<AppState>(context, listen: false).serverUrl;
    String user_id = Provider.of<AppState>(context, listen: false).cred.user_id;
    var body = {
      "user_id": user_id,
      "name": name,
      "description": description,
      "type": "smart",
      "coordinates": {
        "lat": data.latitude,
        "long": data.longitude,
        "accuracy": data.accuracy
      }
    };
    print(body);
    var response = await http
        .post("$url/market/addAddress.php", body: body)
        .timeout(Duration(seconds: 10), onTimeout: () {
      print("timeout reached");
    }).catchError((onError) {
      print("onError");
      print(onError);
    });

    switch (response.statusCode) {
      case 200:
        print("200");
        print(response.body);
        // widget.items.add(_addressCard({
        //   "user_id": user_id,
        //   "name": name,
        //   "description": description,
        //   "coordinates": "{'lat':'','long':''}",
        //   "type": "smart"
        // }));
        await showMessage("Address was Successfully Added.");
        break;
      default:
        await showMessage("Sorry, there was an error.");
        print("Error");
        print(response.statusCode);
        break;
    }
    Navigator.of(context).pop();
  }

  showMessage(String massage) {
    showDialog(
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

  getAddress() async {
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        showMessage("You must enable Location on your phone.");
        getAddress();
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        showMessage("You must grant us permission to access your location");
        getAddress();
      }
    }

    _locationData = await location.getLocation();
    _saveSmartAddress(_addressNameController.value.text,
        _addressDescriptionController.value.text, _locationData);
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  // _initCurrentLocation() {
  //   var _currentPosition;

  //   locator.Geolocator()
  //     // ..forceAndroidLocationManager = !widget.androidFusedLocation
  //     ..getCurrentPosition(
  //       desiredAccuracy: locator.LocationAccuracy.medium,
  //     ).then((position) {
  //       print('position');
  //       print(position);
  //       if (mounted) {
  //         setState(() => _currentPosition = position);
  //       }
  //     }).catchError((e) {
  //       print('position error $e');
  //     });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text("Smart Address")),
        body: Container(
          margin: EdgeInsets.all(20),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width - 10,
                child: Text(
                  "Smart  Addresses are very acurate, they enable us to quicky locate you. However, you have to be physicaly at the address to add it.",
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
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.blueAccent,
                onPressed: () async {
                  if (_addressNameController.value.text != "" &&
                      _addressDescriptionController.value.text != "") {
                    print("hello");
                    await getAddress();
                    // await _initCurrentLocation();
                    print("done");
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
