import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class LyricsView extends StatefulWidget {
  final List<String> lyrics;
  final ValueNotifier<int> currentLineNotifier;

  LyricsView({
    required this.lyrics,
    required this.currentLineNotifier,
  });

  @override
  _LyricsViewState createState() => _LyricsViewState();
}

class _LyricsViewState extends State<LyricsView> {
  ScrollController _scrollController = ScrollController();
  List<String> displayLyrics = [];
  @override
  void initState() {
    super.initState();
    if (widget.lyrics.isEmpty) {
      widget.currentLineNotifier.value = 0;
      displayLyrics = ["No Lyrics Found"];
    } else {
      displayLyrics = widget.lyrics;
    }
    widget.currentLineNotifier.addListener(_scrollToCurrentLine);
  }

  void _scrollToCurrentLine() {
    final index = widget.currentLineNotifier.value;
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        index * 50.0, // assuming each line has a height of 50
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    widget.currentLineNotifier.removeListener(_scrollToCurrentLine);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: displayLyrics.length,
      itemBuilder: (context, index) {
        bool isCurrentLine = widget.currentLineNotifier.value == index;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: displayLyrics[index],
              style: TextStyle(
                // fontFamily: 'Satoshi',
                fontFamily: 'Ranade',
                fontSize: 20.0,
                color: isCurrentLine ? Colors.white : Colors.white70,
                fontVariations: [
                  isCurrentLine
                      ? FontVariation.weight(700)
                      : FontVariation.weight(300)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
