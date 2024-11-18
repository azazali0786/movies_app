import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/movie_repository.dart';
import 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  final MovieRepository movieRepository;

  MovieCubit(this.movieRepository) : super(MovieInitial());

  void fetchAllMovies() async {
    try {
      emit(MovieLoading());
      final movies = await movieRepository.fetchMovies("all");
      emit(MovieLoaded(movies));
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }

  void searchMovies(String query) async {
    try {
      emit(MovieLoading());
      final movies = await movieRepository.fetchMovies(query);
      emit(MovieLoaded(movies));
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }
}
