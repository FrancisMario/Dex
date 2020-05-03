import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextBoxer extends StatefulWidget{
    final String labelText;

   TextBoxer({Key key, this.labelText}) : super(key: key);
    
    @override
    _TextBox createState() => _TextBox();
}
class _TextBox extends State<TextBoxer>{
  final _textBoxController = TextEditingController();

  dynamic getText() {
     return _textBoxController.value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField( 
                  controller: _textBoxController,
                  decoration: new InputDecoration(
                  labelText: widget.labelText,
                    fillColor: Color.fromRGBO(62, 62, 62, 1),
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5.0),
                      borderSide: new BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                );
  }

  
  
}