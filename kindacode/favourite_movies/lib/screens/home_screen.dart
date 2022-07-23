import 'package:favourite_movies/provider/movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/movie.dart';
import 'my_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var movies = context.watch<MovieProvider>().movies;
    var myList = context.watch<MovieProvider>().myList;

    var homeScreenAppBar = AppBar(
      title: const Text('Fave Movies'),
    );

    var goToMyListBtn = ElevatedButton.icon(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const MyListScreen(),
          ),
        );
      },
      icon: const Icon(Icons.favorite),
      label: Text(
        "Go to my List (${myList.length})",
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 20)),
    );

    /// Generates a ListTile for a movie item.
    ListTile newMovieListTile(Movie movie) {
      return ListTile(
        style: Theme.of(context).listTileTheme.style,
        title: Text(movie.title),
        subtitle: Text(movie.runtime ?? 'No information'),
        trailing: IconButton(
          icon: Icon(
            Icons.favorite,
            color: myList.contains(movie)
                ? Theme.of(context).colorScheme.onError
                : Theme.of(context).colorScheme.tertiary,
          ),
          onPressed: () {
            if (myList.contains(movie)) {
              context.read<MovieProvider>().removeFromList(movie);
            } else {
              context.read<MovieProvider>().addToList(movie);
            }
          },
        ),
      );
    }

    /// Generates a Card with movie details.
    Card newMovieItemCard(Movie movie) {
      return Card(
        key: ValueKey(movie.title),
        // color: Colors.amberAccent.shade100,
        elevation: 4,
        child: newMovieListTile(movie),
      );
    }

    var moviesList = Expanded(
      child: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (_, index) {
          final currentMovie = movies[index];
          return newMovieItemCard(currentMovie);
        },
      ),
    );

    var homeScreenBodyChild = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        goToMyListBtn,
        const SizedBox(
          height: 15,
        ),
        moviesList,
      ],
    );

    var homeScreenBody = Padding(
      padding: const EdgeInsets.all(15),
      child: homeScreenBodyChild,
    );

    return Scaffold(
      appBar: homeScreenAppBar,
      body: homeScreenBody,
    );
  }
}
