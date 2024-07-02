import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  var remoteTxt = '';

  void getNext() {
    current = WordPair.random();
    fetchData();
    notifyListeners();
  }

  void fetchData() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      remoteTxt = 'Title: ${data['title']}';
      print(remoteTxt);
    } else {
      throw Exception('Failed to load data');
    }
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var thisText = appState.current.asLowerCase;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('A random idea:'),
            RandomTextCard(thisText: thisText),
            ElevatedButton(
              onPressed: () {
                appState.getNext();
                print('Some one pressed me!');
              },
              child: const Text('Click Me!'),
            )
          ],
        ),
      ),
    );
  }
}

class RandomTextCard extends StatelessWidget {
  const RandomTextCard({
    super.key,
    required this.thisText,
  });

  final String thisText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium
        ?.copyWith(color: theme.colorScheme.onSecondary);

    return Card(
      color: theme.colorScheme.secondary,
      child: Padding(
        padding: const EdgeInsets.all(55.0),
        child: Text(thisText, style: style),
      ),
    );
  }
}
