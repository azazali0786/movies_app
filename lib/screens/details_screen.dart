import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import 'package:html/parser.dart' as html_parser;

class DetailsScreen extends StatelessWidget {
  final Movie movie;

  const DetailsScreen({super.key, required this.movie});
  String stripHtml(String htmlString) {
    final document = html_parser.parse(htmlString);
    return document.body?.text ?? '';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            movie.imageUrl.isNotEmpty
    ? Image.network(
        movie.imageUrl,
      )
    : const Icon(Icons.broken_image, size: 50),
            const SizedBox(height: 16),
            Text(movie.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text(
        stripHtml(movie.summary),
        maxLines: 10,
        overflow: TextOverflow.ellipsis,
      ),
          ],
        ),
      ),
    );
  }
}
