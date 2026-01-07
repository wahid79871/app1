import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Data model to manage the current theme mode.
class ThemeModeData extends ChangeNotifier {
  ThemeMode _currentThemeMode = ThemeMode.system;

  ThemeMode get currentThemeMode => _currentThemeMode;

  void setThemeMode(ThemeMode newMode) {
    if (_currentThemeMode != newMode) {
      _currentThemeMode = newMode;
      notifyListeners();
    }
  }
}

void main() {
  runApp(
    ChangeNotifierProvider<ThemeModeData>(
      create: (BuildContext context) => ThemeModeData(),
      builder: (BuildContext context, Widget? child) {
        return const MyApp();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Listen to changes in ThemeModeData
    final ThemeModeData themeModeData = Provider.of<ThemeModeData>(context);

    return MaterialApp(
      title: 'My Custom App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode:
          themeModeData.currentThemeMode, // Apply the selected theme mode
      home: const LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Welcome'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        const MyHomePage(title: 'Home Page - Logged Account'),
                  ),
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Image.network(
                    'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg',
                    width: 62,
                    height: 62,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 8.0),
                  const Text('Logged account'),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        const MyHomePage(title: 'Home Page - Guest'),
                  ),
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Image.network(
                    'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg',
                    width: 62,
                    height: 62,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 8.0),
                  const Text('Continue without account'),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        const MyHomePage(title: 'Home Page - Photo Sign-in'),
                  ),
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Image.network(
                    'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg',
                    width: 62,
                    height: 62,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 8.0),
                  const Text('Sign in with photo frame'),
                ],
              ),
            ),
            const SizedBox(height: 32.0),

            // Consumer widget to rebuild only the DropdownButton when theme mode changes
            Consumer<ThemeModeData>(
              builder:
                  (
                    BuildContext context,
                    ThemeModeData themeData,
                    Widget? child,
                  ) {
                    return DropdownButton<ThemeMode>(
                      value: themeData.currentThemeMode,
                      onChanged: (ThemeMode? newValue) {
                        if (newValue != null) {
                          themeData.setThemeMode(newValue);
                        }
                      },
                      items: ThemeMode.values.map<DropdownMenuItem<ThemeMode>>((
                        ThemeMode mode,
                      ) {
                        String modeText;
                        switch (mode) {
                          case ThemeMode.system:
                            modeText = 'Default Mode';
                            break;
                          case ThemeMode.light:
                            modeText = 'Light Mode';
                            break;
                          case ThemeMode.dark:
                            modeText = 'Dark Mode';
                            break;
                        }
                        return DropdownMenuItem<ThemeMode>(
                          value: mode,
                          child: Text(modeText),
                        );
                      }).toList(),
                    );
                  },
            ),
            Text('New update'),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pressed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
