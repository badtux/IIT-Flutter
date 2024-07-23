import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'counter.dart'; // Import the file where Counter is defined

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Counter(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Provider Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Provider Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Consumer to rebuild when Counter changes
            Consumer<Counter>(
              builder: (context, counter, child) {
                return Text('Count: ${counter.count}');
              },
            ),
            ElevatedButton(
              onPressed: () {
                // Access and update the Counter state
                context.read<Counter>().increment();
              },
              child: Text('Increment Count'),
            ),
          ],
        ),
      ),
    );
  }
}

