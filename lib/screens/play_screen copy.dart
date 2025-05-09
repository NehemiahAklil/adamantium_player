import 'package:adamantium_player/models/playlist_model.dart';
import 'package:adamantium_player/widgets/custom_app_bar.dart';
import 'package:adamantium_player/widgets/custom_navigation_bar.dart';
import 'package:adamantium_player/widgets/discover_music.dart';
import 'package:adamantium_player/widgets/playlist_card.dart';
import 'package:adamantium_player/widgets/section_header.dart';
import 'package:adamantium_player/widgets/trending_music.dart';
import 'package:flutter/material.dart';

class SongScreen extends StatefulWidget {
  const SongScreen({super.key});

  @override
  State<SongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Playlist> playlists = Playlist.playlists;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              // Colors.deepPurple.shade100.withValues(alpha: 0.8),
              // Colors.deepPurple.shade800.withValues(alpha: 0.8),
              // Colors.deepPurple.shade900.withValues(alpha: 0.9),

              Colors.deepPurple.shade900.withValues(alpha: 0.3),
              Colors.deepPurple.shade900.withValues(alpha: 0.6),
              Colors.deepPurple.shade900.withValues(alpha: 0.8),
              Colors.deepPurple.shade900.withValues(alpha: 0.9),
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
      ),
    );
  }
}
