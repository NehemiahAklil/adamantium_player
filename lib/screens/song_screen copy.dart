import 'dart:io';
import 'dart:math';

import 'package:adamantium_player/models/playlist_model.dart';
import 'package:adamantium_player/models/song_model.dart';
import 'package:adamantium_player/widgets/audio_progress_bar.dart';
import 'package:adamantium_player/widgets/custom_app_bar.dart';
import 'package:adamantium_player/widgets/custom_navigation_bar.dart';
import 'package:adamantium_player/widgets/discover_music.dart';
import 'package:adamantium_player/widgets/playlist_card.dart';
import 'package:adamantium_player/widgets/scrolling_lyrics_text.dart';
import 'package:adamantium_player/widgets/section_header.dart';
import 'package:adamantium_player/widgets/trending_music.dart';
import 'package:audio_service/audio_service.dart';
// import 'package:audiotagger/audiotagger.dart';
// import 'package:audiotagger/models/tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import 'package:solar_icons/solar_icons.dart';

class SongScreen extends StatefulWidget {
  const SongScreen({super.key, required this.song});
  final Song song;
  @override
  State<SongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  late AudioPlayer _audioPlayer;
  // final _tagger = Audiotagger();
  // Tag? _currentMediaTag;
  late Stream<Duration> _positionStream;
  late Stream<Duration?> _durationStream;

  bool isPlaying = false;

  @override
  void initState() {
    _audioPlayer = AudioPlayer();
    _loadAudio();
    _audioPlayer = AudioPlayer();
    _positionStream = _audioPlayer.positionStream;
    _durationStream = _audioPlayer.durationStream;
    super.initState();
  }

  Future<void> _loadAudio() async {
    List<String> _songs = [
      "assets/music/Glenn_Miller_In_The_Mood.mp3",
      "assets/music/Sonny_Rollins_St_Thomas.mp3"
    ];
    final _playlist = ConcatenatingAudioSource(
        useLazyPreparation: true,
        shuffleOrder: DefaultShuffleOrder(),
        children: [
          AudioSource.asset("assets/music/Glenn_Miller_In_The_Mood.mp3"),
          AudioSource.asset("assets/music/Sonny_Rollins_St_Thomas.mp3"),
          // AudioSource.file( "/storage/emulated/0/Music/exteraGram/Trip Lee - Billion Years.mp3")
        ]);
    await _audioPlayer.setAudioSource(_playlist,
        initialIndex: 0, initialPosition: Duration.zero);
    // _currentMediaTag =
    //     await _tagger.readTags(path: _songs[_audioPlayer.currentIndex ?? 0]);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void togglePlayPause() {
    if (_audioPlayer.playing) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
    setState(() {
      isPlaying = _audioPlayer.playing;
    });
  }

  void handleSeek(double value) {
    _audioPlayer.seek(Duration(seconds: value.toInt()));
  }

  Future<void> handleSkipForward(double value) async {
    final currentPosition = _audioPlayer.position;
    final newPosition = currentPosition + Duration(seconds: value.toInt());
    if (newPosition < Duration.zero) {
      _audioPlayer.seek(Duration.zero);
    } else {
      _audioPlayer.seek(newPosition);
    }
  }

  Widget _shuffleButton(BuildContext context, bool isEnabled) {
    return IconButton(
      icon: isEnabled
          ? Icon(Icons.shuffle, color: Theme.of(context).highlightColor)
          : Icon(Icons.shuffle),
      onPressed: () async {
        final enable = !isEnabled;
        if (enable) {
          await _audioPlayer.shuffle();
        }
        await _audioPlayer.setShuffleModeEnabled(enable);
      },
    );
  }

  Future<void> handleSkipBackward(double value) async {
    final currentPosition = _audioPlayer.position;
    final newPosition = currentPosition - Duration(seconds: value.toInt());
    if (newPosition < Duration.zero) {
      _audioPlayer.seek(Duration.zero);
    } else {
      _audioPlayer.seek(newPosition);
    }
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final List<Playlist> playlists = Playlist.playlists;
    ValueNotifier<int> currentLineNotifier = ValueNotifier<int>(8);

    return Scaffold(
      backgroundColor: Colors.transparent,
      // appBar: CustomAppBar(),
      extendBody: true,
      body: Container(
        child: Stack(alignment: Alignment.bottomCenter, children: [
          Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(widget.song.coverUrl),
                      // image: _currentMediaTag != null
                      //     ? AssetImage(_currentMediaTag?.artwork ?? "")
                      //     : AssetImage(widget.song.coverUrl),
                      fit: BoxFit.cover))),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: MediaQuery.of(context).size.width * 0.05),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    // Colors.deepPurple.shade100.withValues(alpha: 0.8),
                    // Colors.deepPurple.shade800.withValues(alpha: 0.8),
                    // Colors.deepPurple.shade900.withValues(alpha: 0.9),

                    Colors.deepPurple.shade900.withValues(alpha: 0.1),
                    Colors.deepPurple.shade900.withValues(alpha: 0.3),
                    Colors.deepPurple.shade900.withValues(alpha: 0.6),
                    Colors.deepPurple.shade900.withValues(alpha: 0.8),
                    Colors.deepPurple.shade900.withValues(alpha: 0.9),
                    Colors.deepPurple.shade900.withValues(alpha: 1),
                    Colors.deepPurple.shade900.withValues(alpha: 1),
                  ]),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          context.pop();
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: MediaQuery.of(context).size.width * 0.08,
                        ),
                      ),
                      Transform.rotate(
                        angle: pi / 2,
                        child: Icon(SolarIconsBold.menuDots,
                            color: Colors.white,
                            size: MediaQuery.of(context).size.width * 0.08),
                      )
                    ],
                  ),
                  Spacer(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width,
                    child: LyricsView(
                        currentLineNotifier: currentLineNotifier,
                        lyrics: widget.song.lyrics == null
                            ? []
                            : widget.song.lyrics?.split("\n") ?? [""]),
                  ),
                  Spacer(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.075,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.song.title,
                              style:
                                  Theme.of(context).textTheme.titleLarge?.apply(
                                fontVariations: [FontVariation.weight(500)],
                              ),
                            ),
                            Text(
                              widget.song.artist,
                              style:
                                  Theme.of(context).textTheme.titleSmall?.apply(
                                fontVariations: [FontVariation.weight(400)],
                              ),
                            ),
                          ],
                        ),
                        Icon(SolarIconsOutline.bookmark)
                      ],
                    ),
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: Column(
                        children: [
                          StreamBuilder<Duration>(
                              stream: _positionStream,
                              builder: (context, snapshot) {
                                final position = snapshot.data ?? Duration.zero;
                                return Slider(
                                  value: position.inSeconds.toDouble(),
                                  thumbColor: Colors.white,
                                  activeColor: Colors.white.withAlpha(200),
                                  inactiveColor: Theme.of(context).primaryColor,
                                  min: 0.0,
                                  max: _audioPlayer.duration != null
                                      ? _audioPlayer.duration!.inSeconds
                                          .toDouble()
                                      : 100.0,
                                  onChanged: (value) => handleSeek(value),
                                );
                              }),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              StreamBuilder<Duration>(
                                stream: _positionStream.cast(),
                                builder: (context, snapshot) {
                                  final duration =
                                      snapshot.data ?? Duration.zero;
                                  return Text(formatDuration(duration));
                                },
                              ),
                              StreamBuilder<Duration>(
                                stream: _durationStream
                                    .where((duration) => duration != null)
                                    .cast(),
                                builder: (context, snapshot) {
                                  final duration =
                                      snapshot.data ?? Duration.zero;
                                  return Text(formatDuration(duration));
                                },
                              ),
                            ],
                          )
                        ],
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    // width: MediaQuery.of(context).size.width * 0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        StreamBuilder<bool>(
                          stream: _audioPlayer.shuffleModeEnabledStream,
                          builder: (context, snapshot) {
                            return _shuffleButton(
                                context, snapshot.data ?? false);
                          },
                        ),
                        IconButton(
                          onPressed: _audioPlayer.hasPrevious
                              ? _audioPlayer.seekToPrevious
                              : null,
                          icon: Icon(
                            SolarIconsBold.skipPrevious,
                            size: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.fontSize,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            handleSkipBackward(10);
                          },
                          icon: Icon(
                            Icons.replay_10_rounded,
                            size: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.fontSize,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            togglePlayPause();
                          },
                          icon: isPlaying
                              ? Icon(SolarIconsBold.pauseCircle, size: 72)
                              : Icon(SolarIconsBold.playCircle, size: 72),
                        ),
                        IconButton(
                          onPressed: () {
                            handleSkipForward(10.0);
                          },
                          icon: Icon(
                            Icons.forward_10_rounded,
                            size: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.fontSize,
                          ),
                        ),
                        IconButton(
                          onPressed: _audioPlayer.hasNext
                              ? _audioPlayer.seekToNext
                              : null,
                          icon: Icon(
                            SolarIconsBold.skipNext,
                            size: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.fontSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            borderRadius:
                                BorderRadius.circular(30), // Adjust as needed
                            splashColor: Colors.grey[300],
                            highlightColor: Colors.grey[100],
                            onTap: () {},
                            child: Icon(
                              SolarIconsOutline.infoCircle,
                              size: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.fontSize,
                            )),
                        InkWell(
                          borderRadius:
                              BorderRadius.circular(30), // Adjust as needed
                          splashColor: Colors.grey[300],
                          highlightColor: Colors.grey[100],
                          onTap: () {},
                          child: Icon(
                            SolarIconsBold.playlist,
                            size: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.fontSize,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
