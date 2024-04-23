// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var currentWordPair = WordPair.random();

  void getNext() {
    notifyListeners();
    currentWordPair = WordPair.random(); /*notifyListeners();*/
  } // order doesn't matter
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.currentWordPair;

    return Scaffold(
      body: Center(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
           mainAxisAlignment: MainAxisAlignment.center,        
          children: [
            // const Padding(padding: EdgeInsets.only(left: 450)),
            // const Padding( padding: EdgeInsets.only(left: 100), child: Text('A random Starter App idea:')),
            const Text('A random Starter App idea:'),
            const SizedBox(height: 10,),
            BigCard(pair: pair),
            const SizedBox(height: 15,),

            // Added this button
            ElevatedButton(
              onPressed: () {
                print('button pressed');
                // appState.current = WordPair.random();  //Changes data under the hood but doesn't update ui
                appState.getNext();
              },
              child: const Text('Next'),
            )
          ],
        ),
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // For consistency, use already defined theme

    /// Calling copyWith() on displayMedium returns a copy of the text style with the changes you define.
    final style = theme.textTheme.displayMedium!.copyWith(color: theme.colorScheme.onPrimary);                                                                                  

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        // Flutter Preffers make everything (including attributes) Widgets (elements) for seperation of responsibility
        padding: const EdgeInsets.all(30.0),
        child: Text(pair.asLowerCase, style: style, semanticsLabel: "${pair.first} ${pair.second}",),
      ),
    );
  }
}
