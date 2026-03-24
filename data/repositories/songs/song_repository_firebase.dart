import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../model/songs/song.dart';
import '../../dtos/song_dto.dart';
import 'song_repository.dart';

class SongRepositoryFirebase extends SongRepository {
  static Uri baseUrl = Uri.https(
    "week-8-practice-5d28b-default-rtdb.asia-southeast1.firebasedatabase.app",
  );
  final Uri songsUri = baseUrl.replace(path: "/songs.json");

  @override
  Future<List<Song>> fetchSongs() async {
    final http.Response response = await http.get(songsUri);

    if (response.statusCode == 200) {
      // 1 - Send the retrieved list of songs
      Map<String, dynamic> songJson = json.decode(response.body);
      final List<Song> result = [];
      for (var entry in songJson.entries) {
        result.add(
          SongDto.fromJson(entry.key, entry.value as Map<String, dynamic>),
        );
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
