import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Toast Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ToastDemoScreen(),
    );
  }
}

class ToastDemoScreen extends StatelessWidget {
  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toast Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showToast("This is a toast message!");
          },
          child: Text('Show Toast'),
        ),
      ),
    );
  }
}
