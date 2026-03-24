import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:theory_lesson/W9%20-%20PRACTICE%20-%20Firebase%20Part%201/data/dtos/artist_dto.dart';
import 'package:theory_lesson/W9%20-%20PRACTICE%20-%20Firebase%20Part%201/model/artists/artist.dart';

import '../../../model/songs/song.dart';
import '../../dtos/song_dto.dart';
import 'song_repository.dart';

class SongRepositoryFirebase extends SongRepository {
  static Uri baseUrl = Uri.https(
    "week-8-practice-5d28b-default-rtdb.asia-southeast1.firebasedatabase.app",
  );
  final Uri songsUri = baseUrl.replace(path: "/songs.json");
  final Uri artistUri = baseUrl.replace(path: "/artists.json");
  @override
  Future<List<Song>> fetchSongs() async {
    final http.Response songsResponse = await http.get(songsUri);
    final http.Response artistsResponse = await http.get(artistUri);

    if (songsResponse.statusCode == 200 && artistsResponse.statusCode == 200) {
      // 1 - Send the retrieved list of songs
      Map<String, dynamic> songJson = json.decode(songsResponse.body);
      Map<String, dynamic> artistData = json.decode(artistsResponse.body);
      final List<Song> result = [];

      for (var entry in songJson.entries) {
        final songMap = entry.value as Map<String, dynamic>;
        final artistId = songMap['artistId'];

        final artistMap = artistData[artistId];

        if (artistMap != null) {
          final artistObject = ArtistDto.formJson(artistId, artistMap);

          result.add(
            Song(
              id: entry.key,
              title: songMap['title'],
              artist: artistObject,
              duration: Duration(milliseconds: songMap['duration']),
              imageUrl: Uri.parse(songMap['imageUrl']),
            ),
          );
        }
      }
      return result;
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load posts');
    }
  }

  @override
  Future<Song?> fetchSongById(String id) async {}
}
