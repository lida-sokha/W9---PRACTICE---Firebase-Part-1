import 'package:provider/provider.dart';
import 'package:theory_lesson/W9%20-%20PRACTICE%20-%20Firebase%20Part%201/data/repositories/artists/artist_repository.dart';
import 'package:theory_lesson/W9%20-%20PRACTICE%20-%20Firebase%20Part%201/data/repositories/artists/artists_repository_firebase.dart';
 
import 'data/repositories/songs/song_repository_firebase.dart';
import 'main_common.dart';
import 'data/repositories/settings/app_settings_repository_mock.dart';
import 'data/repositories/songs/song_repository.dart';
import 'ui/states/player_state.dart';
import 'ui/states/settings_state.dart';

/// Configure provider dependencies for dev environment
List<InheritedProvider> get devProviders {
  final appSettingsRepository = AppSettingsRepositoryMock();

  return [
 
    // 1 - Inject the song repository
    Provider<SongRepository>(create: (_) => SongRepositoryFirebase()),

    // 2 - Inject the player state
    ChangeNotifierProvider<PlayerState>(create: (_) => PlayerState()),

    // 3 - Inject the  app setting state
    ChangeNotifierProvider<AppSettingsState>(
      create: (_) => AppSettingsState(repository: appSettingsRepository),
    ),
    
    // 4- Inject the artist repository
    Provider<ArtistRepository>(create: (_)=> ArtistsRepositoryFirebase())
  ];
}

void main() {
  mainCommon(devProviders);
}
