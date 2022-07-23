import 'package:favourite_movies/provider/movie_provider.dart';
import 'package:favourite_movies/screens/home_screen.dart';
import 'package:favourite_movies/themes/color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider<MovieProvider>(
      child: const MyApp(),
      create: (_) => MovieProvider() // Create new ChangeNotifier object.
      ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Disable debug banner.
      debugShowCheckedModeBanner: false,
      title: 'Favourite Movies',
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      home: const HomeScreen(),
    );
  }
}
