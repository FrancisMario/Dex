import 'package:dex/newOrder.dart';
import 'package:dex/voiceMessage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<void> _makePhoneCall(String url) async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        print("call error ");
      }
    }

    confirmCall() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Alert"),
              content: Text("Do you want to call DEX support"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Close"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    _makePhoneCall('tel:+2203188982');
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }

    return Container(
        child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(padding: EdgeInsets.only(bottom: 20)),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return NewOrder();
                    }));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius:
                              10.0, // has the effect of softening the shadow
                          spreadRadius:
                              5.0, // has the effect of extending the shadow
                          offset: Offset(
                            10.0, // horizontal, move right 10
                            10.0, // vertical, move down 10
                          ),
                        )
                      ],
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.red,
                    ),
                    height: 150,
                    width: 150,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.textsms,
                            size: 100,
                            color: Colors.white,
                          ),
                          Text(
                            "Custom Order",
                            style: TextStyle(fontSize: 20, color: Colors.white,fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 10)),
                GestureDetector(
                  onTap: () {
                    // Redirect to the page
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return VoiceMessage();
                    }));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius:
                              10.0, // has the effect of softening the shadow
                          spreadRadius:
                              5.0, // has the effect of extending the shadow
                          offset: Offset(
                            10.0, // horizontal, move right 10
                            10.0, // vertical, move down 10
                          ),
                        )
                      ],
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.red,
                    ),
                    height: 150,
                    width: 150,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.mic,
                            size: 100,
                            color: Colors.white,
                          ),
                          Text(
                            "Voice",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
          Padding(padding: EdgeInsets.only(bottom: 20)),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    confirmCall();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius:
                              10.0, // has the effect of softening the shadow
                          spreadRadius:
                              5.0, // has the effect of extending the shadow
                          offset: Offset(
                            10.0, // horizontal, move right 10
                            10.0, // vertical, move down 10
                          ),
                        )
                      ],
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.red,
                    ),
                    height: 150,
                    width: 150,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.call,
                            size: 100,
                            color: Colors.white,
                          ),
                          Text(
                            "Help",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 10)),
                GestureDetector(
                  onTap: () {
                    // Redirect to the page
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.transparent,
                    ),
                    height: 150,
                    width: 150,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[],
                      ),
                    ),
                  ),
                ),
              ])
        ],
      ),
    ));
  }
}
