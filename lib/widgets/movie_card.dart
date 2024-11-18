import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import 'package:html/parser.dart' as html_parser;

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
   
  String stripHtml(String htmlString) {
    final document = html_parser.parse(htmlString);
    return document.body?.text ?? '';
  }
    return Card(
      child: ListTile(
        leading: movie.imageUrl.isNotEmpty
    ? Image.network(
        movie.imageUrl,
        width: 50,
        height: 80,
        fit: BoxFit.cover,
      )
    : const Icon(Icons.broken_image, size: 50),
        title: Text(movie.title),
        subtitle: Text(
        stripHtml(movie.summary),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      ),
    );
  }
}
