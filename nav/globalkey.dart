import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drawer with Button Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  // Sample data array
  final List<String> drawerItems = List<String>.generate(20, (i) => "Drawer Item $i");

  // GlobalKey to control the Scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Drawer with Button Demo'),
      ),
      drawer: Drawer(
        child: ListView.builder(
          itemCount: drawerItems.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(Icons.label),
              title: Text(drawerItems[index]),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Handle tap event
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Tapped on ${drawerItems[index]}')),
                );
                Navigator.pop(context); // Close the drawer
              },
            );
          },
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          child: Text('Open Drawer'),
        ),
      ),
    );
  }
}
