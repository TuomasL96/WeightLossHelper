import 'package:flutter/material.dart';
import 'package:open_weight_tracker/user_repository.dart';
import 'user_creation_menu.dart';
import 'main_user_menu.dart';
import 'objectbox_store.dart';
import 'models.dart';

late ObjectBox objectBox;
UserRepository userRepository = UserRepository();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectBox = await ObjectBox.create();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            onPrimaryContainer: Colors.white,
            onSecondaryContainer: Colors.deepPurple,
            onTertiaryContainer: Colors.deepPurpleAccent,
          ),
          useMaterial3: true,
          inputDecorationTheme: const InputDecorationTheme(
              filled: true,
              fillColor: Colors.white30,
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(8.0))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = UserMainMenu();
        break;
      case 1:
        page = UserProfileCreatorMenu();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                minWidth: 60,
                minExtendedWidth: 60,
                extended: constraints.maxWidth >= 800,
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.man_3),
                    label: Text('User'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.auto_graph_outlined),
                    label: Text('Weight'),
                  ),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            Expanded(
              //flex: 1,
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}
