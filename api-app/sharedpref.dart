import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DataScreen(),
    );
  }
}

class DataScreen extends StatefulWidget {
  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  List<String> _data = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Load data from local storage
  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _data = prefs.getStringList('data') ?? [];
    });
  }

  // Add some data to local storage
  Future<void> _addData(String item) async {
    final prefs = await SharedPreferences.getInstance();
    final currentData = prefs.getStringList('data') ?? [];
    currentData.add(item);
    await prefs.setStringList('data', currentData);
    _loadData(); // Reload data after adding
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Local Storage Example'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_data[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () => _addData('Item ${_data.length + 1}'),
              child: Text('Add Item'),
            ),
          ),
        ],
      ),
    );
  }
}
