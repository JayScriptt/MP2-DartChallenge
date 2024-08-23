import 'dart:math';

void main() {
  print('MP2 - Dart Challenge: Song Playlist Manager');
  print('Cornelio Gatbonton Jr');

  // Create song objects
  Music opening1 = Music('AOT Opening 1', 'Linked Horizon', 120);
  Music opening2 = Music('Naruto Opening 1', 'Takanori Nishikawa', 96);
  Music opening3 = Music('One Piece Opening 5', 'Kota Shinzato', 112);
  Music opening4 = Music('Attack on Titan Opening 2', 'Linked Horizon', 115);
  Music opening5 = Music('My Hero Academia Opening 1', 'Lamar', 102);
  Music opening6 = Music('Tokyo Ghoul Opening', 'TK from Ling Tosite Sigure', 108);
  Music opening7 = Music('Fullmetal Alchemist Opening 1', 'L’Arc-en-Ciel', 99);

  // Create playlists and add songs
  Playlist mainStage = Playlist('Main Stage');
  mainStage.addMusic(opening1);
  mainStage.addMusic(opening2);
  mainStage.addMusic(opening3);
  mainStage.addMusic(opening4);
  mainStage.addMusic(opening5);

  Playlist indieStage = Playlist('Indie Stage');
  indieStage.addMusic(opening6);
  indieStage.addMusic(opening4);
  indieStage.addMusic(opening1);

  Playlist electronicStage = Playlist('Electronic Stage');
  electronicStage.addMusic(opening7);
  electronicStage.addMusic(opening3);
  electronicStage.addMusic(opening2);

  // Create a music festival and add playlists
  MusicFestival festival = MusicFestival('Anime Fest');
  festival.addStage(mainStage);
  festival.addStage(indieStage);
  festival.addStage(electronicStage);

  // Show total festival duration
  print('Total Festival Duration: ${festival.totalFestivalDuration()} seconds\n');
  // Show random songs from each playlist
  festival.displayRandomMusics();

  // Sort and show songs in the main stage by artist
  mainStage.sortMusicsByArtist();
  print('Main Stage playlist sorted by artist:\n');
  mainStage.displayPlaylist();
}
// Represents a piece of music.
class Music {
  String musicTitle;  // Title of the song
  String artistName;  // Artist who made the song
  int musicDuration;  // Song length in seconds

  // Initializes a Music object
  Music(this.musicTitle, this.artistName, this.musicDuration);

  // Shows song details in a readable format
  String displayMusic() {
    int minutes = musicDuration ~/ 60;  // Convert seconds to minutes
    int seconds = musicDuration % 60;  // Remaining seconds
    return '$musicTitle by $artistName (${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')})';
  }
}

// Represents a playlist of music.
class Playlist {
  String playlistName;  // Name of the playlist
  List<Music> musicsList = [];  // List of songs

  // Initializes a Playlist object
  Playlist(this.playlistName);

  // Adds a song to the playlist
  void addMusic(Music music) {
    musicsList.add(music);
  }

  // Shows all songs in the playlist
  void displayPlaylist() {
    print('Playlist: $playlistName');
    musicsList.forEach((music) => print(music.displayMusic()));
  }

  // Sorts songs by artist name
  void sortMusicsByArtist() {
    musicsList.sort((a, b) => a.artistName.compareTo(b.artistName));
  }
}

// Represents a music festival with multiple playlists.
class MusicFestival {
  String festivalName;  // Name of the festival
  List<Playlist> stagesList = [];  // List of playlists

  // Initializes a MusicFestival object
  MusicFestival(this.festivalName);

  // Adds a playlist to the festival
  void addStage(Playlist playlist) {
    stagesList.add(playlist);
  }

  // Shows festival details
  void displayFestival() {
    print('Music Festival: $festivalName');
    stagesList.forEach((stage) {
      stage.displayPlaylist();  // Show each playlist
      print('---');
    });
  }

  // Calculates total duration of all songs
  int totalFestivalDuration() {
    return stagesList
        .expand((stage) => stage.musicsList)  // Combine all songs
        .fold(0, (total, music) => total + music.musicDuration);  // Add up lengths
  }

  // Shows a random song from each playlist
  void displayRandomMusics() {
    print('Random Songs:');
    stagesList.forEach((stage) {
      Music randomMusic = stage.musicsList[Random().nextInt(stage.musicsList.length)];
      print('${stage.playlistName}: ${randomMusic.displayMusic()}');
    });
  }
}
