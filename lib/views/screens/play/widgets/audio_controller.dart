import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioController extends StatelessWidget {
  final AudioPlayer player;
  const AudioController({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<PlayerState>(
        stream: player.playerStateStream,
        builder: (context, snapshot) {
          final playerState = snapshot.data;
          final processingState = playerState?.processingState;
          final playing = playerState?.playing;
          if (processingState == ProcessingState.loading ||
              processingState == ProcessingState.buffering) {
            return const CircularProgressIndicator();
          } else if (playing != true) {
            return IconButton(
              icon: const Icon(Icons.play_arrow_rounded, color: Colors.white),
              iconSize: 64.0,
              onPressed: player.play,
            );
          } else if (processingState != ProcessingState.completed) {
            return IconButton(
              icon: const Icon(Icons.pause_circle_rounded, color: Colors.white),
              iconSize: 64.0,
              onPressed: player.pause,
            );
          } else {
            return IconButton(
              icon: const Icon(Icons.replay_10_rounded, color: Colors.white),
              iconSize: 64.0,
              onPressed: () => player.seek(Duration.zero),
            );
          }
        },
      ),
    );
  }
}
