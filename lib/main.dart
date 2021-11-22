//@dart=2.9
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty/providers/character_provider.dart';
import 'package:rick_morty/screens/character_details_screen.dart';
import 'package:rick_morty/screens/character_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (ctx) => CharacterProvider(), lazy: false),
      ],
      child: MaterialApp(
        title: 'Rick and Morty',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.grey[850],
          backgroundColor: Color.fromRGBO(60, 62, 68, 1),
          scaffoldBackgroundColor: Color.fromRGBO(36, 40, 47, 1),
          appBarTheme: AppBarTheme(backgroundColor: Colors.grey[850]),
          primarySwatch: Colors.blue,
        ),
        home: const CharacterListScreen(),
        routes: {
          CharacterDetailsScreen.routeName: (ctx) =>
              const CharacterDetailsScreen()
        },
      ),
    );
  }
}
