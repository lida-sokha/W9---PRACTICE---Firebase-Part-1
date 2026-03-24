import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../model/artists/artist.dart';
import '../../dtos/artist_dto.dart';
import 'artist_repository.dart';

class ArtistsRepositoryFirebase extends ArtistRepository {
  static Uri baseUrl = Uri.https(
    "week-8-practice-5d28b-default-rtdb.asia-southeast1.firebasedatabase.app",
  );
  final Uri artistUri = baseUrl.replace(path: "/artists.json");
  @override
  Future<List<Artist>> fetchArtist() async {
    final http.Response response = await http.get(artistUri);

    if (response.statusCode == 200) {
      Map<String, dynamic> artistJson = json.decode(response.body);
      final List<Artist> result = [];
      for (var entry in artistJson.entries) {
        result.add(
          ArtistDto.formJson(entry.key, entry.value as Map<String, dynamic>),
        );
      }
      return result;
    } else {
      throw Exception('Failded to load');
    }
  }

  @override
  Future<Artist?> fetchArtistById(String id) async {}
}
