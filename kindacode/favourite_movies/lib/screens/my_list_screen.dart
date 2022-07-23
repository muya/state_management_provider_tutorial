import 'package:favourite_movies/provider/movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/movie.dart';

class MyListScreen extends StatefulWidget {
  const MyListScreen({Key? key}) : super(key: key);

  @override
  State<MyListScreen> createState() => _MyListScreenState();
}

class _MyListScreenState extends State<MyListScreen> {
  @override
  Widget build(BuildContext context) {
    final _myList = context.watch<MovieProvider>().myList;

    var myListScreenAppBar = AppBar(title: Text("My List (${_myList.length})"));

    // Generates a List tile for a liked movie item.
    ListTile newMovieListTile(Movie movie) {
      return ListTile(
        title: Text(movie.title),
        subtitle: Text(movie.runtime ?? ''),
        trailing: TextButton(
          child: Text(
            'Remove',
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
          onPressed: () {
            context.read<MovieProvider>().removeFromList(movie);
          },
        ),
      );
    }

    /// Generates a Card with liked movie details.
    Card newMovieItemCard(Movie movie) {
      return Card(
        key: ValueKey(movie.title),
        elevation: 4,
        child: newMovieListTile(movie),
      );
    }

    var myListScreenBody = ListView.builder(
      itemCount: _myList.length,
      itemBuilder: (_, index) {
        final currentLikedMovie = _myList[index];

        return newMovieItemCard(currentLikedMovie);
      },
    );

    return Scaffold(
      appBar: myListScreenAppBar,
      body: myListScreenBody,
    );
  }
}
