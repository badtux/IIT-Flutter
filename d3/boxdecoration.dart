import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;

  CustomCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.purple],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Custom Card Example')),
        body: Center(
          child: CustomCard(
            child: Text('Hello, Flutter!', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}