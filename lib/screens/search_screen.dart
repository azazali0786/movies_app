import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/screens/details_screen.dart';
import '../cubits/movie_cubit.dart';
import '../cubits/movie_state.dart';
import '../widgets/movie_card.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search Movies")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (query) {
                BlocProvider.of<MovieCubit>(context).searchMovies(query);
              },
              decoration: InputDecoration(
                hintText: "Search...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<MovieCubit, MovieState>(
              builder: (context, state) {
                if (state is MovieLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MovieLoaded) {
                  final movies = state.movies;
                  return ListView.builder(
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => DetailsScreen(movie: state.movies[index]),
                      ));
                    },
                        child: MovieCard(movie: movies[index]));
                    },
                  );
                } else if (state is MovieError) {
                  return Center(child: Text(state.message));
                }
                return const Center(
                  child: Text("Start typing to search for movies."),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
