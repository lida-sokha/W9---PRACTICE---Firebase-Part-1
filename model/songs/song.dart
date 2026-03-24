import 'package:theory_lesson/W9%20-%20PRACTICE%20-%20Firebase%20Part%201/model/artists/artist.dart';

class Song {
  final String id;
  final String title;
  final Artist artist;
  final Duration duration;
  final Uri imageUrl;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.duration,
    required this.imageUrl
  });

  @override
  String toString() {
    return 'Song(id: $id, title: $title, artist: $artist, duration: $duration, imageUrl: $imageUrl)';
  }
}
