import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Read TextField App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TextFieldDemo(),
    );
  }
}

class TextFieldDemo extends StatefulWidget {
  @override
  _TextFieldDemoState createState() => _TextFieldDemoState();
}

class _TextFieldDemoState extends State<TextFieldDemo> {
  TextEditingController _textController = TextEditingController();
  String _displayText = '';

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _showText() {
    setState(() {
      _displayText = _textController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read TextField'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Enter some text',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _showText();
              },
              child: Text('Show Text'),
            ),
            SizedBox(height: 20.0),
            Text(
              'Text entered: $_displayText',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
