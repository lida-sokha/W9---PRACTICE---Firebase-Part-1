import '../../model/artists/artist.dart';

class ArtistDto {
  static const String nameKey = 'name';
  static const String genreKey = 'genre';
  static const String imageKey = 'imageUrl';

  static Artist formJson(String id, Map<String, dynamic> json) {
    assert(json[nameKey] is String);
    assert(json[genreKey] is String);
    assert(json[imageKey] is String);

    return Artist(
      id: id,
      name: json[nameKey],
      genre: json[genreKey],
      imageUrl: Uri.parse(json[imageKey]),
    );
  }

  Map<String, dynamic> toJson(Artist artist) {
    return {
      nameKey: artist.name,
      genreKey: artist.genre,
      imageKey: artist.imageUrl.toString(),
    };
  }
}
