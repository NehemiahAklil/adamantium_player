import 'package:adamantium_player/models/playlist_model.dart';
import 'package:adamantium_player/widgets/custom_app_bar.dart';
import 'package:adamantium_player/widgets/custom_navigation_bar.dart';
import 'package:adamantium_player/widgets/discover_music.dart';
import 'package:adamantium_player/widgets/trending_music.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/song_model.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // bool _permissionGranted = false;
  bool _permissionGranted = false;

  @override
  void initState() {
    super.initState();
    _requestPermission();
  }

  Future<void> _requestPermission() async {
    var status = await Permission.audio.request();
    debugPrint(status.toString());
    if (status.isGranted) {
      setState(() {
        _permissionGranted = true;
      });
    } else {
      // Handle permission denied
      setState(() {
        _permissionGranted = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Song> songs = Song.songs;
    final List<Playlist> playlists = Playlist.playlists;
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.deepPurple.shade800.withValues(alpha: 0.8),
                Colors.deepPurple.shade100.withValues(alpha: 0.8),
              ]),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: CustomAppBar(),
          extendBody: true,
          bottomNavigationBar: const CustomNavigationBar(),
          body: SingleChildScrollView(
              child: Column(
            children: [
              const DiscoverMusic(),
              TrendingMusic(songs: songs),
              Container(
                margin: EdgeInsets.only(bottom: 30.0),
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const SectionHeader(title: 'Playlist'),
                    ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(top: 20),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: playlists.length,
                        itemBuilder: (context, index) {
                          return PlaylistCard(playlist: playlists[index]);
                        }),
                  ],
                ),
              )
            ],
          )),
        ));
  }
}
