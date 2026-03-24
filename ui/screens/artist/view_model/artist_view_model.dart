import 'package:flutter/material.dart';
import '../../../../data/repositories/artists/artist_repository.dart';
import '../../../../model/artists/artist.dart';
import '../../../utils/async_value.dart';

class ArtistViewModel extends ChangeNotifier {
  final ArtistRepository artistRepository;

  AsyncValue<List<Artist>> artistValue = AsyncValue.loading();

  ArtistViewModel({required this.artistRepository}) {
    _init();
  }

  void _init() async {
    fetchArtist();
  }

  void fetchArtist() async {
    artistValue = AsyncValue.loading();
    notifyListeners();
    try {
      List<Artist> artists = await artistRepository.fetchArtist();
      artistValue = AsyncValue.success(artists);
    } catch (e) {
      artistValue = AsyncValue.error(e);
    }
    notifyListeners();
  }
}
