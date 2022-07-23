import 'dart:math';

import 'package:favourite_movies/models/movie.dart';
import 'package:flutter/material.dart';

// List of available movies.
final List<Movie> initialData = List.generate(
  50,
  (index) => Movie(
    title: "Movie $index",
    runtime: "${Random().nextInt(100) + 60} minutes",
  ),
);

/// Manages state (information about movies) of the application, and handles
/// logic to manage movie lists.
class MovieProvider with ChangeNotifier {
  // All movies that will be displayed on teh Home screen.
  final List<Movie> _movies = initialData;

  // Retrieves all movies.
  List<Movie> get movies => _movies;

  // Favourite movies that will be shown on the MyList screen.
  final List<Movie> _myList = [];

  // Retrieves favourite movies list.
  List<Movie> get myList => _myList;

  // Adds a movie to the favourites list.
  void addToList(Movie movie) {
    _myList.add(movie);
    notifyListeners();
  }

  // Removes a movie from the favourites list.
  void removeFromList(Movie movie) {
    _myList.remove(movie);
    notifyListeners();
  }
}
