import 'package:flutter/material.dart';

class AudioProgressBar extends StatefulWidget {
  const AudioProgressBar({super.key});

  @override
  State<AudioProgressBar> createState() => _AudioProgressBarState();
}

class _AudioProgressBarState extends State<AudioProgressBar> {
  double _progressValue = 0.0;

  @override
  void initState() {
    super.initState();
    _startProgress();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _startProgress() async {
    for (double i = 0.0; i <= 1.0; i += 0.1) {
      await Future.delayed(const Duration(milliseconds: 500));
      setState(() {
        _progressValue = i;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          LinearProgressIndicator(
            value: _progressValue,
          ),
        ],
      ),
    );
  }
}
