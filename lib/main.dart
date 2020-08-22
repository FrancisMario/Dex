import 'package:dex/appState.dart';
import 'package:dex/base.dart';
import 'package:dex/checkOutAddress.dart';
import 'package:dex/detailedEntityView.dart';
import 'package:dex/entityList.dart';
import 'package:dex/setup.dart';
import 'package:dex/testWidget.dart';
import 'package:dex/marketPlace.dart';
import 'package:dex/displayShoppingCart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
   MyApp({Key key}) : super(key: key);
  @override 
  _MyApp createState() => _MyApp();
  }

class _MyApp extends State<MyApp>{
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
      ],
      child: Consumer<AppState>(
        builder: (context, appState, _) {
          return MaterialApp(
            theme: ThemeData(
          // This is the theme of your application.
              primarySwatch: Colors.red,
            ),
            debugShowCheckedModeBanner: false,
            home:  Home(key:widget.key),
            // home:  Setup(key:widget.key),
            // home: CategoryView(),
            // home: DetailedCategoryView(),
            // home: DetailedEntityView(),
            // home: CheckOutAddress(),
          );
        },
      ),
    );
  }
}
