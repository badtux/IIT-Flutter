import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }
}

class MyAppState2 extends ChangeNotifier {
  var current = WordPair.random();

  void getRemote() {
    String _data = 'Click the button to fetch data';

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      Map<String, dynamic> data = jsonDecode(response.body);
      setState(() {
        _data = 'Title: ${data['title']}'; // Update UI with fetched data
      });
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load data');
    }
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
