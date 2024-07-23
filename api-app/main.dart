import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'person.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Person List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PersonListScreen(),
    );
  }
}

class PersonListScreen extends StatefulWidget {
  @override
  _PersonListScreenState createState() => _PersonListScreenState();
}

class _PersonListScreenState extends State<PersonListScreen> {
  late Future<List<Person>> futurePeople;

  @override
  void initState() {
    super.initState();
    futurePeople = fetchPeople();
  }

  Future<List<Person>> fetchPeople() async {
    final response = await http.get(Uri.parse('http://localhost/api.php')); // Update this URL as needed

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((person) => Person.fromJson(person)).toList();
    } else {
      throw Exception('Failed to load people');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Person List'),
      ),
      body: Center(
        child: FutureBuilder<List<Person>>(
          future: futurePeople,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('No data available');
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final person = snapshot.data![index];
                  return ListTile(
                    title: Text(person.name),
                    subtitle: Text(person.number),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
