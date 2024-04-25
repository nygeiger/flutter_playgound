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
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var currentWordPair = WordPair.random();

  void getNext() {
    notifyListeners();
    currentWordPair = WordPair.random(); /*notifyListeners();*/
  } // order doesn't matter. (Adds to stack and value has already changed by the time it's popped??)

  var favorites =
      <WordPair>[]; // Final?  The <...> portion is considered a "Generic" -> https://dart.dev/language/generics

  void toggleFavorite() {
    if (favorites.contains(currentWordPair)) {
      favorites.remove(currentWordPair);
    } else {
      favorites.add(currentWordPair);
    }
    notifyListeners();
  }
}

/* class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.currentWordPair;

     // ↓ Add this.
    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Scaffold(
      body: Center(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const Padding(padding: EdgeInsets.only(left: 450)),
            // const Padding( padding: EdgeInsets.only(left: 100), child: Text('A random Starter App idea:')),
            const Text('A random Starter App idea:'),
            const SizedBox(
              height: 10,
            ),
            BigCard(pair: pair),
            const SizedBox(
              height: 15,
            ),

            // Added this button
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    print('Like button pressed');
                    // appState.current = WordPair.random();  //Changes data under the hood but doesn't update ui
                    appState.toggleFavorite();
                  },
                  icon: Icon(icon),
                  label: const Text('Like'),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    print('Next button pressed');
                    // appState.current = WordPair.random();  //Changes data under the hood but doesn't update ui
                    appState.getNext();
                  },
                  child: const Text('Next'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
} */

// ...

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SafeArea( // The SafeArea ensures that its child is not obscured by a hardware notch or a status bar. 
            child: NavigationRail(
              extended: false,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.favorite),
                  label: Text('Favorites'),
                ),
              ],
              selectedIndex: 0,
              onDestinationSelected: (value) {
                print('selected: $value');
              },
            ),
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: GeneratorPage(),
            ),
          ),
        ],
      ),
    );
  }
}

class GeneratorPage extends StatelessWidget {
  const GeneratorPage({super.key});
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.currentWordPair;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      // child: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     BigCard(pair: pair),
      //     SizedBox(height: 10),
      //     Row(
      //       mainAxisSize: MainAxisSize.min,
      //       children: [
      //         ElevatedButton.icon(
      //           onPressed: () {
      //             appState.toggleFavorite();
      //           },
      //           icon: Icon(icon),
      //           label: Text('Like'),
      //         ),
      //         SizedBox(width: 10),
      //         ElevatedButton(
      //           onPressed: () {
      //             appState.getNext();
      //           },
      //           child: Text('Next'),
      //         ),
      //       ],
      //     ),
      //   ],
      // ),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // const Padding(padding: EdgeInsets.only(left: 450)),
          // const Padding( padding: EdgeInsets.only(left: 100), child: Text('A random Starter App idea:')),
          const Text('A random Starter App idea:'),
          const SizedBox(
            height: 10,
          ),
          BigCard(pair: pair),
          const SizedBox(
            height: 15,
          ),

          // Added this button
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  print('Like button pressed');
                  // appState.current = WordPair.random();  //Changes data under the hood but doesn't update ui
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: const Text('Like'),
              ),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  print('Next button pressed');
                  // appState.current = WordPair.random();  //Changes data under the hood but doesn't update ui
                  appState.getNext();
                },
                child: const Text('Next'),
              ),
            ],
          )
        ],
      ),
    );
  }
}

// ...

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme =
        Theme.of(context); // For consistency, use already defined theme

    /// Calling copyWith() on displayMedium returns a copy of the text style with the changes you define.
    final style = theme.textTheme.displayMedium!
        .copyWith(color: theme.colorScheme.onPrimary);

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        // Flutter Preffers make everything (including attributes) Widgets (elements) for seperation of responsibility
        padding: const EdgeInsets.all(30.0),
        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}
