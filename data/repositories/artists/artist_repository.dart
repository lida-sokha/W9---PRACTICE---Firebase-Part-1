import '../../../model/artists/artist.dart';

abstract class ArtistRepository {
  Future<List<Artist>> fetchArtist();
  
   Future<Artist?> fetchArtistById(String id);
}
